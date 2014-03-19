##
# Freenas package dependencies
##

freenas-dependencies:
  pkg.installed:
    - names:
      - nginx
      - qemu-kvm
      - python-pip
      - sqlite3
      #- libjs-dojo-core
      - python-requests
      - python-dev
      - python-mimeparse
      - python-dateutil
      - python-daemon
      - python-simplejson
      - python-greenlet
      - python-eventlet
      - libavahi-compat-libdnssd1
      - libdb5.1 #Berkley DB
      - python-bsddb3
      - slapd # Requires user input for admin password on install
      - ldap-utils 
      - python-ldap
      - python-libxml2
      - python-dbus
      - python-six
      - python-lockfile
      - python-pexpect
    - require:
      - file: /usr/include/python2.7/pyconfig.h

# Replace system pyconfig.h for PyXml since its missing '#define HAVE_MEMMOVE 1'
/usr/include/python2.7/pyconfig.h:
  file.managed:
    - installed: python-dev
    - source: salt://freenas/files/usr/include/python2.7/pyconfig.h
    - user: root
    - group: root
    - mode: 644
    - installed:
      - pkg: python-dev

freenas-pips:
  pip.installed:
    - names:
      - django
      - django-tastypie
      - django-json-rpc
      - flup
      - dojango
      - dnspython
      - httplib2
      - oauth2
      - south
      - ipaddr
      - polib
      - pyasn1
      - pyasn1-modules
      # sysctl did not compile, but it looks like its included with salt
      #- sysctl editable=git+https://github.com/williambr/py-sysctl.git 
    - require:
      - pkg: pip-dependencies
    - installed: python-dev

# dojo libraries
# --------------
# - git clone https://github.com/dojo/dojo.git
# - git clone https://github.com/dojo/dojox.git
# - git clone https://github.com/dojo/dijit.git
#
/var/www/dojo:
  file.recurse:
    - source: salt://freenas/files/var/www/dojo
    - user: www-data
    - group: www-data
    - file_mode: 644
    - dir_mode: 755

# More difficult to install packages OR missing files
# ---------------------------------------------------
#git clone https://github.com/freenas/freenas.git /srv/freenas
#chown -R www-data /srv/freenas/gui/
#cp -pr /srv/freenas/gui /var/www/freenasUI
#cd /var/www/freenasUI

# Missing Files
# -------------
# If I used scp; I had to grab from running freenas system (worry about generating later)

#scp rc.subr root@10.0.0.10:/var/www
#ln -s /var/www/rc.subr /etc/rc.subr
#
#scp /etc/version root@10.0.0.10:/var/www
#ln -s /var/www/version /etc/version
#
#scp local_settings.py root@10.0.0.10:/var/www
#ln -s /var/www/local_settings.py /etc/local_settings.py
#ln -s /var/www/local_settings.py /var/www/freenasUI/local_settings.py
#
#scp -r nginx-dist root@10.0.0.10:/var/www
#ln -s /var/www/nginx-dist nginx
#
#cp /srv/freenas/nanobsd/Files/etc/rc.freenas /var/www
#ln -s /var/www/rc.freenas /etc/rc.freenas
#
#
#cp -rp /srv/freenas/nanobsd/Files/etc/directoryservice /var/www/directoryservice
#ln -s /var/www/directoryservice /etc/directoryservice
#
#/usr/sbin/zpool - missing; dont have zfs installed; commented out section in migrations that refers to it



