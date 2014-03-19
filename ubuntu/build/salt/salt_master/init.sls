##
# Salt Master states file
##

# Install development version from git
salt-master:
  pkg.installed:
    - name: salt-master 
    - editable: https://github.com/saltstack/salt.git
    - install_options: "-b develop"
    - upgrade: True
  service.running:
    - name: salt-master
    - require:
      - pkg: salt-master
    - watch:
      - file: /etc/salt/master
      - file: /etc/pki/tls/certs/localhost.crt
      - file: /etc/pki/tls/certs/localhost.key
      - file: /etc/pki/tls/certs/localhost.pem

# Configuration file for master
/etc/salt/master:
  file.managed:
    - source: salt://salt_master/conf
    - user: root
    - group: root
    - mode: 644

# Localhost tls certificate 
/etc/pki/tls/certs/localhost.crt:
  file.managed:
    - source: salt://salt_master/localhost.crt
    - user: root
    - group: root
    - mode: 644

# Localhost tls key
/etc/pki/tls/certs/localhost.key:
  file.managed:
    - source: salt://salt_master/localhost.key
    - user: root
    - group: root
    - mode: 644

# Localhost tls certificate and key
/etc/pki/tls/certs/localhost.pem:
  file.managed:
    - source: salt://salt_master/localhost.pem
    - user: root
    - group: root
    - mode: 644
