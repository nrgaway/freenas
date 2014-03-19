# Network Configuration
#

#system:
#  network.system:
#    - enabled: True
#    - hostname: haswell.local
#    - gateway: 10.0.0.1
##    - gatewaydev: em1
##    - nozeroconf: True
##    - nisdomain: example.com
##    - require_reboot: True


em1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: manual


#    - bridge: br0
#    - byfassfirewall: True

br0:
  network.managed:
    - enabled: True
    - type: bridge
    - proto: none
    - ipaddr: 10.0.0.10
    - netmask: 255.255.255.0
    - gateway: 10.0.0.1
    - dns:
       - 10.0.0.1
    - ports: em1
    - delay: 0
    - use:
      - network: em1
    - require:
      - network: em1
