postfix:
  mydestination:  mail,
                  localhost.localdomain,
                  localhost

  # TODO; use grain to lookup localhost and subnet
  #mynetworks: "127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 10.0.0.0/24"
  mynetworks: "127.0.0.0/8 [::ffff:127.0.0.0]/104"

  #virtual:

  aliases: |
      # Basic system aliases
      mailer-daemon:   postmaster
      postmaster:      root

      # General redirections for pseudo accounts.
      bin:             root
      daemon:          root
      adm:             root
      lp:              root
      sync:            root
      shutdown:        root
      halt:            root
      mail:            root
      news:            root
      uucp:            root
      operator:        root
      games:           root
      gopher:          root
      ftp:             root
      nobody:          root
      radiusd:         root
      nut:             root
      dbus:            root
      vcsa:            root
      canna:           root
      wnn:             root
      rpm:             root
      nscd:            root
      pcap:            root
      apache:          root
      webalizer:       root
      dovecot:         root
      fax:             root
      quagga:          root
      radvd:           root
      pvm:             root
      amanda:          root
      privoxy:         root
      ident:           root
      named:           root
      xfs:             root
      gdm:             root
      mailnull:        root
      postgres:        root
      sshd:            root
      smmsp:           root
      postfix:         root
      netdump:         root
      ldap:            root
      squid:           root
      ntp:             root
      mysql:           root
      desktop:         root
      rpcuser:         root
      rpc:             root
      nfsnobody:       root

      ingres:          root
      system:          root
      toor:            root
      manager:         root
      dumper:          root
      abuse:           root

      # mailman aliases
      mailman:         postmaster
      mailman-owner:   mailman

      newsadm:         news
      newsadmin:       news
      usenet:          news
      ftpadm:          ftp
      ftpadmin:        ftp
      ftp-adm:         ftp
      ftp-admin:       ftp

      # trap decode to catch security attacks
      decode:          root

      # Person who should get root's mail
      root:            administrator

      # Custom aliases
      administrator:   admin
      Brenda:          brenda
      Paige:           paige
      Jason:           jason

