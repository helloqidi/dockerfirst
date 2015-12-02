#!/bin/sh
# rvm wrapper ruby-2.1.2@cuanhuo bootup unicorn
UNICORN=/home/helloqidi/.rvm/bin/bootup_unicorn
CONFIG_FILE=/opt/project/cuanhuo/config/unicorn.rb
APP_HOME=/opt/project/cuanhuo
 
case "$1" in
  start)
  bundle exec $UNICORN -c $CONFIG_FILE -E production -D
  ;;
  stop)
  kill -QUIT `cat /tmp/unicorn_cuanhuo.pid`
  ;;
  restart|force-reload)
    kill -USR2 `cat /tmp/unicorn_cuanhuo.pid`
  ;;
  *)
   echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2
   exit 3
   ;;
esac
 
:
