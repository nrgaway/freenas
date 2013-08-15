from urlparse import parse_qs
import logging

from django.test.client import Client, FakePayload

from tastypie.test import ResourceTestCase, TestApiClient
from freenasUI.api.models import APIClient
from freenasUI.system.models import Advanced, Settings
import oauth2

log = logging.getLogger('api.tests.utils')


class OAuth2Client(Client):

    def request(self, **request):

        is_form_encoded = \
            request.get('CONTENT_TYPE') == 'application/x-www-form-urlencoded'
        _input = request.get('wsgi.input')
        if _input:
            data = request.get('wsgi.input').read()
            request['wsgi.input'] = FakePayload(data)
        else:
            data = ''
        method = request.get('REQUEST_METHOD')
        path = request.get('PATH_INFO')

        if is_form_encoded and data:
            parameters = parse_qs(data)
        else:
            parameters = None

        req = oauth2.Request.from_consumer_and_token(self._consumer,
            token=None, http_method=method, http_url="http://testserver%s" % path,
            parameters=parameters, body=data, is_form_encoded=is_form_encoded)
        req.sign_request(oauth2.SignatureMethod_HMAC_SHA1(), self._consumer, None)

        request['HTTP_AUTHORIZATION'] = req.to_header()['Authorization']
        print request

        return super(OAuth2Client, self).request(**request)


class OAuth2APIClient(TestApiClient):

    def __init__(self, consumer=None, *args, **kwargs):
        super(OAuth2APIClient, self).__init__(*args, **kwargs)
        self.client = OAuth2Client()
        consumer = oauth2.Consumer(
            key=consumer.name,
            secret=consumer.secret,
        )
        self.client._consumer = consumer


class APITestCase(ResourceTestCase):

    def setUp(self):
        super(APITestCase, self).setUp()
        self.api = APIClient.objects.create(name='test')
        self.api_client = OAuth2APIClient(consumer=self.api)
        Settings.objects.create()
        Advanced.objects.create()