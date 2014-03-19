##
# salt-halite
# -----------
# (Code-name) Halite is a Salt GUI. Status is pre-alpha. 
# Contributions are very welcome. Join us in #salt on Freenode or on the salt-users mailing list.
##

halite-dependencies:
  pkg.installed:
    - names:
      - gcc
      - python-dev
      - libevent-dev

halite-pips:
  pip.installed:
    - names:
      - CherryPy 
      - gevent
      - halite #git+https://github.com/saltstack/halite.git
    - require:
      - pkg: pip-dependencies
    - installed: 
      - gcc
      - python-dev
      - libevent-dev
