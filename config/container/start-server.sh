#!/bin/bash
cd /rails
#source /etc/profile.d/rvm.sh
#bundle exec unicorn -D -p 8080
/usr/sbin/sshd
service unicorn start  
nginx
