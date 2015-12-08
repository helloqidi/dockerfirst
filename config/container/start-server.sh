#!/bin/bash
cd /rails
#source /etc/profile.d/rvm.sh
source /etc/profile
bundle exec unicorn -c /rails/config/unicorn.rb -E production -D
#bundle exec SECRET_KEY_BASE=82dfbba16a4fbf76114d0bed04a588315211dbf8e3917cf18df0fecae886db3a5566fd5d02131341f2125250125749bda4e9efe048e93c53cbf0caa15fd4ba8b unicorn -c /rails/config/unicorn.rb -E production -D
nginx
