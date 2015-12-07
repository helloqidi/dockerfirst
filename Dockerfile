# Dockerfile for a Rails application using Nginx and Unicorn
 
# Select ubuntu as the base image
FROM ubuntu
 
# Install nginx, nodejs and curl
RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
 
# Install rvm, ruby, bundler
RUN apt-get -y install gcc g++ make automake autoconf make libc6-dev patch openssl ca-certificates libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libgdbm-dev libncurses5-dev libtool bison pkg-config libffi-dev zlib1g-dev openssh-server curl libedit-dev wget
WORKDIR /tmp
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
RUN tar -zxvf ruby-2.2.2.tar.gz
WORKDIR /tmp/ruby-2.2.2
RUN ["./configure"]
RUN make -j2
RUN make install -j2
RUN ruby -v
RUN /bin/bash -l -c "gem source -r https://rubygems.org/"
RUN /bin/bash -l -c "gem source -a https://ruby.taobao.org"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
 
# Add configuration files in repository to filesystem
ADD config/container/nginx-sites.conf /etc/nginx/sites-enabled/default
ADD config/container/start-server.sh /usr/bin/start-server
RUN chmod +x /usr/bin/start-server

# Add rails project to project directory
ADD ./ /rails
 
# set WORKDIR
WORKDIR /rails
 
# bundle install
RUN /bin/bash -l -c "bundle install"
RUN bundle exec RAILS_ENV=production rake assets:precompile
 
# Publish port 80
EXPOSE 80
 
# Startup commands
ENTRYPOINT /usr/bin/start-server
