kvm-packages:
  pkg.installed:
    - pkgs:
      - qemu-kvm
      - libvirt-bin
      - qemu-system
      - bridge-utils
      - virt-manager
      - virt-viewer
      - virt-goodies
      - virt-top
      - virtinst
      - python-libvirt
      - ubuntu-vm-builder
      - spice-client-gtk
      - spice-client
#      - vlan
#      - guestfish
#      - guestfsd
#      - guestmount
#      - lvm2
#      - nfs-common
#      - munin-libvirt-plugins
#      - munin-node
#      - multipath-tools

# TODO: Make sure user jason added to libvirtd

/etc/libvirt/qemu.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 444
    - source: salt://kvm/qemu.conf
    - require:
      - pkg: kvm-packages

kvmhostkey:
  ssh_auth.present:
    - user: root
    - source: salt://users/keys/master.id_rsa.pub

/root/.ssh/id_rsa:
  file.managed:
    - user: root
    - group: root
    - mode: 600
    - user: root
    - source: salt://users/keys/master.id_rsa

libvirt-bin:
  service.running:
    - require:
      - pkg: kvm-packages
      - file: /etc/libvirt/qemu.conf
      - ssh_auth: kvmhostkey
    - watch: 
      - file: /etc/libvirt/qemu.conf

#vm.swappiness:
#  sysctl.present:
#    - value: 0

#vm.zone_reclaim_mode:
#  sysctl.present:
#    - value: 0

net.bridge.bridge-nf-call-arptables:
  sysctl.present:
    - value: 0

#/hugepages:
#  mount.mounted:
#    - device: hugetlbfs
#    - fstype: hugetlbfs
#    - mkmnt: True

#grub-settings:
#  file.append:
#    - name: /etc/default/grub
#    - text: 'GRUB_CMDLINE_LINUX_DEFAULT="console=ttyS0,9600n8 console=tty0 text nosplash nomodeset nohz=off transparent_hugepage=always"'
#  file.append:
#    - name: /etc/default/grub
#    - text: 'GRUB_CMDLINE_LINUX="console=ttyS0,9600n8 console=tty0 text nosplash nomodeset nohz=off transparent_hugepage=always"'

#update-grub:
#  cmd.run:
#    - name: update-grub
#    - require:
#      - file.append: grub-settings
