# 基于镜像 ruby 2.2.0
FROM centos

# 安装Ruby
RUN curl -L https://get.rvm.io | bash -s stable
RUN source ~/.rvm/scripts/rvm
RUN rvm install 2.2.3
RUN rvm use 2.2.3 --default
RUN gem source -r https://rubygems.org/
RUN gem source -a https://ruby.taobao.org

# 安装bundler
RUN rvm gemset use global
RUN gem install bundler

# 安装Rails
ENV RAILS_VERSION 4.2.5
RUN gem install rails --version "$RAILS_VERSION" --no-ri --no-rdoc

# 创建代码所运行的目录
RUN mkdir -p /usr/src/app

# 将代码添加到目录中
ADD ./ /usr/src/app

# 切换目录
WORKDIR /usr/src/app

# 安装所需的 gems
RUN bundle install --without development test

# 设定服务的端口，使 webserver 可以在容器外面访问
EXPOSE 3000

# 添加可执行权限
RUN chmod +x unicorn.sh

# 将 rails 项目（和 Dockerfile 同一个目录）添加到项目目录
ADD ./ /usr/src/app

# 启动 web 应用
#ENTRYPOINT ./unicorn.sh start
ENTRYPOINT rails start -E production -D
