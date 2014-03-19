# Make sure nginx is installed and up

nginx:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: nginx
      - file: www_root

# Make sure the default web directory exists and permissions are set correctly
www_root:
  file.directory: 
    - name: /var/www
    - makedirs: True
    - user: www-data
    - group: www-data

