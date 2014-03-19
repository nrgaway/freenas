# Install mutt and postfix mutt packages.
#
# This formula supports setting an optional:
#
#  * 'aliases' file 
#  * 'virtual' map file
#  * 'mydestination' data
#  * 'mynetworks' data
#
# All additional options use a pillar data schema
# which takes the following form: 
# 
# postfix:
#   aliases: |
#       postmaster: root
#       root: testuser
#       testuser: russell@example.com
#   virtual: |
#       example.com             this is a comment
#       test1@example.com       me@example.com
#       test2@example.com       me@example.com
#       
#   mydestination: mail,
#                  mail.example.com,
#                  localhost.localdomain,
#                  localhost
#
#   mynetworks: "127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 10.0.0.0/24"


# install mutt
mutt:
  pkg:
    - installed

# install postfix have service watch main.cf

postfix:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: postfix
    - watch: 
      - file: /etc/postfix/main.cf
      - file: /etc/postfix/sasl
      - file: /etc/postfix/ssl

#
# Configuration files for postfix
#

# sasl configuration
/etc/postfix/sasl:
  file.recurse:
    - source: salt://postfix/config/sasl
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - require:
      - pkg: postfix

# ssl certificates
/etc/postfix/ssl:
  file.recurse:
    - source: salt://postfix/config/ssl
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - require:
      - pkg: postfix

# postfix main configuration file
/etc/postfix/main.cf:
  file.managed:
    - source: salt://postfix/config/main.cf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: postfix

# manage /etc/aliases if data found in pillar
{% if 'aliases' in pillar.get('postfix', '') %}
/etc/aliases:
  file.managed:
    - source: salt://postfix/config/aliases
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: postfix

run-newaliases:
  cmd.wait:
    - name: newaliases
    - cwd: /
    - watch:
      - file: /etc/aliases
{% endif %}

# manage /etc/postfix/virtual if data found in pillar
{% if 'virtual' in pillar.get('postfix', '') %}
/etc/postfix/virtual:
  file.managed:
    - source: salt://postfix/config/virtual
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: postfix

run-postmap:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/virtual
    - cwd: /
    - watch:
      - file: /etc/postfix/virtual
{% endif %}
