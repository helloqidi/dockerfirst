#!/bin/bash
cd /rails
#source /etc/profile.d/rvm.sh
source /etc/profile
bundle exec unicorn -D -p 8080
nginx
