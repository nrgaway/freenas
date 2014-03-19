snmpd:
  pkg:
    - installed
  service:
    - name: snmpd
    - dead
    - enable: False
    - require:
      - pkg: snmpd
