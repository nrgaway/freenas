# Add more static hosts bellow
salt_host:
  host.present:
    - name: salt
    - ip: localhost

master_host:
  host.present:
    - name: master
    - ip: localhost

staging_host:
  host.present:
    - name: staging
    - ip: staging.local
