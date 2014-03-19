snmpd:
  pkg:
    - installed
  service:
    - running
    - name: snmpd
    - require:
      - pkg: snmpd

snmpd.conf:
  file:
    - managed
    - name: /etc/snmp/snmpd.conf
    - source: salt://default/snmpd/snmpd.conf
    - user: root
    - group: root
    - mode: 600
    - require:
      - pkg: snmpd
    - watch_in:
      - service: snmpd
