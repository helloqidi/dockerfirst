#!/bin/bash
cd /rails
#source /etc/profile.d/rvm.sh
source /etc/profile
bundle exec unicorn -c /rails/config/unicorn.rb -E production -D
nginx
