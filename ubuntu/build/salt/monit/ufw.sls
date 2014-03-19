# ufw monit checkers

extend:
  monit:
    service:
      - require:
        - file: /etc/monit/conf.d/ufw
      - watch:
        - file: /etc/monit/conf.d/ufw

/etc/monit/check-ufw.sh:
  file.managed:
    - source: salt://monit/conf/check-ufw.sh
    - mode: 755
/etc/monit/conf.d/ufw:
  file.managed:
    - source: salt://monit/conf/conf.d/ufw
    - require:
      - file: /etc/monit/check-ufw.sh
