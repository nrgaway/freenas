base:


  '*':
    - python_pip

    # Only for trusty installations
    {% if grains['os'] == 'Ubuntu' and grains['lsb_distrib_codename'] == 'trusty' %}
    {% endif %}

    # Core packages
    - apt_sources
    - salt_master
    - salt_minion
    - core

    # Networking Packages
#    - firewall.internal
    - firewall.disabled
    - hosts
    - nfs.client
    - nfs.server

    - memcache

    # Monitoring Watchdog
    - monit
    - monit.app
#    - monit.db
#    - monit.ufw
    - monit.master
    - monit.memcache
    - monit.nfs

    # Freenas UI specific
    - nginx
    - freenas

  'kvm':
    - match: nodegroup
#    - wsproxy
#    - cluster
    - kvm
#    - network

  'develop':
    - match: nodegroup
    - debs.wingide5
    - ssh.enabled
    - snmpd.enabled
    - jenkins
    - salt_halite
    - monitoring_packages

