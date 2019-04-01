# Yorlook - Now named Taddar
Taddars mission is to be the best at tagging products on social media images and videos.

Taddars first goal is for users to like images on instagram. And we show the products in Taddars Mobile App.

# Trello Board
Trello is used for creating and managing tasks.
https://trello.com/b/HaqRp0O6/yorlook

# Copyright
This application is owned by Joseph Konop, Brisbane Australia.

Copyright (C) name: Joseph Konop email: josephkonop@gmail.com, Inc - All Rights Reserved

This file is part of Taddar.

Taddars can not be copied and/or distributed without the express permission of Joseph Konop

## How to setup the project

1. Clone the project:

        git clone git@github.com:joeyk16/yorlook.git
        cd yorlook

2. Copy config files from example and use yours:

        cp config/application.yml.example config/application.yml
        cp config/database.yml.example config/database.yml

3. Run the following commands:

        bundle install
        npm install
        rake db:schema:load
        rake db:seed

4. Create categories

        rake db:setup_categories

5. Start the app:

        rails s

6. Run sidekick if crawling

        bundle exec sidekiq

## Taddars Mobile App Repo
iOS and Android. React Native.
https://github.com/joeyk16/taddar_mobile_app

## Production Server
url: www.taddar.com
ssh: `ssh deploy@52.34.30.10`
restart server: `passenger-config restart-app`

## When Crawling on Development make sure you run
rake jobs:work

## SSH Production
`ssh deploy@52.34.30.10`

## Current when sshing
`cd taddar/current`

## Rails Console when sshing
`bundle exec rails c production`

## Production Logs
`sudo tail -f /var/log/nginx/error.log`

## Ngrok
https://ngrok.com/download
./ngrok http 3000

## AWS RDS database
username: admin@taddar.com
password: Something starting with v

## Restart Nginx on production
`sudo /opt/nginx/sbin/nginx`

## How to start sidekiq on production
`bundle exec sidekiq -c 2 -e production -L log/sidekiq.log -d`

## Sidekiq production log
`sudo tail -f ./log/sidekiq.log`

## How to start redis
`redis-server`

## How to install redis on production
https://medium.com/@andrewcbass/install-redis-v3-2-on-aws-ec2-instance-93259d40a3ce

## Stop Redis on production
`service /etc/init.d/redis_6379 stop`

## PR's that could revert
Payments: https://github.com/joeyk16/yorlook/pull/216
Messages: https://github.com/joeyk16/yorlook/pull/202
Tagging System: https://github.com/joeyk16/yorlook/pull/217
product_location_yml_file: https://github.com/joeyk16/yorlook/pull/299
