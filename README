===========================
Fork of FreeNAS (for Linux)
===========================

I am in the process of porting ``FreeNAS for BSD`` initially over to ``Ubuntu server 14.04``. See the progress notes below to keep up with the development cycle.

Some of the ``FreeNAS`` developers wanted to make sure I make clear that this is a fork of the original project only which will carry a different name as to not confuse the marketplace as they already have a well established and tested brand name.

I decided to port ``FreeNAS`` since I got really, really good benchmarks with ``BTRFS`` using the 3.13 kernel (almost double that of 3.11 kernel). I was able to write as fast as using ``ZFS`` which prompted the conversion of ``FreeNAS`` to ``Ubuntu`` since I like the framework it uses (python, django).

Benchmarks
==========

.. code-block:: text

    All tests have large image file (53687091712 bytes) on ssd and rsync'ed to hdd
    All file systems are mounted with default mount settings
    System load is a =< 0.08 when starting
    All system loads are checked via 'uptime' right after transfer
    
    uptime && rsync --progress -av /root/file.img /mnt/<mounted_file_system> && uptime
    
    System:
    Intel 4th generation i7
    24GB DDR3 RAM
    6 Seagate 7200 RPM drives partitioned into 10 100GB sections for each file system type
    
    FREENAS (9.2.2)
    ---------------
    (source image file on SSD zfs partition)
    
     |---------------------> System load after rsync job
     |       |-------------> Average speed of transfer (bytes/sec)
     |       |           |-> file system type / configuration          
    X.XX - 225,130,588 - ZFS-raidz2
    
    
    UBUNTU 14.04 (3.13 kernel)
    --------------------------
    (source file on lvm2 + btrfs SSD partition)
    
     |---------------------> System load after rsync job
     |       |-------------> Average speed of transfer (bytes/sec)
     |       |           |-> file system type / configuration          
    2.50 - 126,502,235 - btrfs (btrfs single)
    1.98 - 128,315,887 - ext4 (ext4 single)
    2.18 - 382,506,707 - btrf_array (btrfs array of 6 disks)
    2.16 - 382,217,414 - btrfs_raid (btrfs raid 6 array of 6 disks)
    2.65 - 371,627,675 - btrfs_luks_raid (btrfs raid 6 on 6 individually encrypted disks)
    2.44 - 371,695,543 - mdraid6 (btrfs on mdraid 6 - no lvm)
    6.67 - 184,724,942 - mdraid_crypt (btrfs on luks on mdraid6)
    2.67 - 356,173,930 - ext4_mdraid  (ext4 on mdraid 6 - no lvm)
    6.08 - 221,764,447 - ext4_raid_crypt (ext4 on luks on mdraid6)
    
    Notes:
    - No zfs tests since only fuse driver was available and had really poor performance
    - Writes to single drives are very slow
    - Writes to mdraid where a single luks volume is created on top on mdraid is slow and creates a high system load.
    - It seems when 6 luks volumes are created, then btrfs_raid added on top of that is an ideal configuration
    
    UBUNTU 13.10 (3.11.0-18 kernel)
    -------------------------------
    (source image file on ext4 SSD partition - no lvm2)  
    
     |---------------------> System load after rsync job
     |       |-------------> Average speed of transfer (bytes/sec)
     |       |           |-> file system type / configuration          
     3.68 - 121,616,410 - btrfs (btrfs single)
     1.69 -  83,569,876 - ext4 (ext4 single)
     1.26 -  74,419,467 - btrf_array (btrfs array of 6 disks)
     1.41 -  77,090,661 - btrfs_raid (btrfs raid 6 array of 6 disks)
    37.40 - 124,723,915 - btrfs_luks_raid (btrfs raid 6 on 6 individually encrypted disks)
     1.31 -  64,886,580 - mdraid6 (btrfs on mdraid 6 - no lvm)
     7.04 -  74,009,159 - mdraid_crypt (btrfs on luks on mdraid6)
     1.43 -  49,831,689 - ext4_mdraid  (ext4 on mdraid 6 - no lvm)
     1.89 -  81,415,686 - ext4_raid_crypt (ext4 on luks on mdraid6)
     1.19 -  95,285,972 - (zfs native 0.6.1 raidz2 on 6 disks)

Features to Expect
==================

-    I am replacing most middleware components of ``FreeNAS`` with the ``Salt`` API. ``Salt`` (http://www.saltstack.com/) allows administration of computers for multiple platform types which will allow the middleware components to work with both ``BSD`` and ``Linux`` (maybe ``Mac`` and ``Windows`` as well).

-    ``Linux`` does not have ``jails``, but we do have ``Docker`` :) ``Docker`` (https://www.docker.io/) containers already have many many existing 'plugins' that will just work so they will be easy to install.

-    I also have the personal requirement of running and managing some local virtual machines, so will be adding a section to create and manage them.

-    Users will still have the choice of using ``ZFS`` and in addition ``BTRFS`` (via ``mdraid`` or ``BTRFS`` raid) with encryption, compression and snapshots similar to what ``ZFS`` has.

-    Will initially be able to be installed on top of an existing Linux installation which means the OS will need to be installed first. We will see where it goes from there.

Notes and Progress to Date
==========================

-    Don't bother trying to install the build here yet.  The master branch is still a copy of the original code base minus this README.  My development work is currently in the ``experimental/ubuntu`` branch which will not be merged to this fork master until it is ready to test with
-    I currently have a build that installs most of the dependencies required to start the UI web service
-    Initial installations will come pre-configured with a complete development environment to aid in debugging and monitoring.  

TODO (This list is mostly for my benefit)
=========================================

-   Working on converting the middleware layer to make it cross compatible with Linux and Mac while still supporting BSD (so the website actually does something useful hehe). There are a lot of ``BSD`` specifics to work around.
-   Change any configuration files that have static information like ipaddress to retrieve data via pillar or grains.  For example we can grab assigned ip address, gateway, etc on boot from grains and we can user pillars to store information like aliases.
-   make defualt Linux account name 'admin' and give sudo rights to that user. It will be created if it does not exist and the user id will be 98; a 'guest' user will also be created as id 99.  

Certificates are missing from the initial configuration and need to be automatically generated.  Maybe some of them can actually be shared :)

- postfix (freenas/ubuntu/build/salt/postfix/config/ssl)
    - cacert.pem
    - cakey.pem 
    - smtpd.crt
    - smtpd.csr
    - smtpd.key
- salt_master (freenas/ubuntu/build/salt/salt_master)
    - localhost.crt
    - localhost.key
    - localhost.pem
- users/keys (freenas/ubuntu/build/salt/users/keys):
    - master.id_rsa
    - master.id_rsa.pub

.. ............................................................................
.. _`unnamedNAS`: https://github.com/nrgaway/freenas
