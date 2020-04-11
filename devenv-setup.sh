#!/bin/bash

dbuser="$1"
dbpass="$2"
appname="stocks"

sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.7.1
rvm use 2.7.1 --default
ruby -v
gem install bundler
gem install rails -v 6.0.2.2
rails -v
sudo apt install postgresql-11 libpq-dev
sudo -u postgres createuser $dbuser -s
sudo -u postgres psql
postgres=# \password $dbpass

rails new $appname -d postgresql
cd $appname
sed -i -e "s/username:.*/username: $dbuser" -e "s/password:.*/password: $dbpass" config/database.yml
rake db:create
echo "$appname app is being started on http://localhost:3000"
rails server
