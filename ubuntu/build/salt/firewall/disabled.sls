# Firewall rules for internal hosts
# Check https://help.ubuntu.com/community/UFW for refernce

firewall:
  service:
    - name: ufw
    - enable: False
    - dead
