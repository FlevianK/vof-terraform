#!/bin/bash

set -e
set -o pipefail

create_vof_user() {
  if ! id -u vof; then
    sudo useradd -m -s /bin/bash vof
  fi
}

<<<<<<< HEAD
install_system_dependencies() {
  sudo apt-get update -y

  sudo apt-get install -y --no-install-recommends git-core curl zlib1g-dev logrotate     \
    build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev \
    sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev wget nodejs unattended-upgrades     \
    python-software-properties libffi-dev libpq-dev sudo vim less supervisor jq \
    postgresql postgresql-contrib
}

install_ruby(){
  if ! which ruby; then
    install_system_dependencies

    sudo chgrp -R vof  /usr/local
    sudo chmod -R g+rw /usr/local

    curl -k -O -L "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%\.*}/ruby-${RUBY_VERSION}.tar.gz"
    tar zxf ruby-*

    pushd ruby-$RUBY_VERSION
      ./configure
      make && make install
    popd
  fi
}

install_vof_ruby_dependencies() {
  if ! which bundler; then
    curl -O -L -k https://rubygems.org/rubygems/rubygems-2.6.12.tgz

    tar zxf rubygems-2.6.12.tgz
    pushd rubygems-2.6.12
      ruby setup.rb
    popd

    gem install bundler --no-ri --no-rdoc
    gem install stackdriver --no-ri --no-rdoc
  fi
}

=======
>>>>>>> c198b0b169b72d6b1436b115fa3883e1d6e00169
start_supervisor_service() {
  sudo service supervisor start
}

setup_vof_code() {
  sudo chown -R vof:vof /home/vof
  
  cd /home/vof/app && bundle install
}

install_logging_agent(){
  # This installs the logging agent into the VM
  curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
  sudo bash install-logging-agent.sh
}

main() {
  create_vof_user

  setup_vof_code
  install_logging_agent
  start_supervisor_service
}

main "$@"
