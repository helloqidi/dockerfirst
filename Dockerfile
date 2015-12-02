# 基于镜像 ruby 2.2.0
FROM ruby:2.2.0

# 安装所需的库和依赖
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 设置 Rails 版本
ENV RAILS_VERSION 4.2.5

# 安装 Rails
RUN gem source -r https://rubygems.org/
RUN gem source -a https://ruby.taobao.org
RUN gem install bundler
RUN gem install rails --version "$RAILS_VERSION" --no-ri --no-rdoc

# 创建代码所运行的目录
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# 使 webserver 可以在容器外面访问
EXPOSE 3000

# 设置环境变量
ENV PORT=3000

# 安装所需的 gems
ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install --without development test

# 添加
ADD unicorn.sh /usr/bin/start-server
RUN chmod +x /usr/bin/start-server

# 将 rails 项目（和 Dockerfile 同一个目录）添加到项目目录
ADD ./ /usr/src/app

# 运行 rake 任务
RUN RAILS_ENV=production rake db:create db:migrate

# 启动 web 应用
ENTRYPOINT /usr/bin/start-server
