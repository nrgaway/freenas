#!/bin/bash

# Start django debug
/var/www/freenasUI/manage.py runfcgi method=threaded host=127.0.0.1 port=9042 daemonize=false
