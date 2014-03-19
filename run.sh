#!/bin/bash

# Start django
/usr/bin/python /var/www/freenasUI/manage.py runfcgi method=threaded host=127.0.0.1 port=9042 pidfile=/var/run/django.pid
