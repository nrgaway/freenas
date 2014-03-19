# 
# Freenas installation and configuration
# Platform: for Ubuntu Server 14.04
#

include:
  - freenas.packages

vhosts_freenas:
  require:
    - pkg: nginx
    - file: /etc/nginx/nginx.conf
    - file: /etc/nginx/sites-available/freenas
    - file: /etc/nginx/sites-enabled/freenas
    - file: /etc/nginx/plugins.conf
    - file: /etc/nginx/timestamp
  watch:
    - file: /etc/nginx/nginx.conf
    - file: /etc/nginx/sites-available/freenas
    - file: /etc/nginx/sites-enabled/freenas
    - file: /etc/nginx/plugins.conf
    - file: /etc/nginx/timestamp
    - require:
      - pkg: nginx

# Custom nginx configuration (FIXME: extend origianl, don't overwrite)
/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://vhosts/conf/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

# Freenas vhost server coniguration file
/etc/nginx/sites-available/freenas:
  file.managed:
    - source: salt://vhosts/conf/sites-available/freenas
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx

# Enable the freenas vhost
/etc/nginx/sites-enabled/freenas:
  file.symlink:
    - target: /etc/nginx/sites-available/freenas
    - source: /etc/nginx/sites-enabled/freenas
    - require:
      - pkg: nginx

# We refer to plugins.conf but dont have any so make sure it exists
/etc/nginx/plugins.conf:
  file.touch:
    - require:
      - pkg: nginx

/etc/nginx/timestamp:
  file.managed:
    - source: salt://vhosts/conf/timestamp
    - require:
      - pkg: nginx

