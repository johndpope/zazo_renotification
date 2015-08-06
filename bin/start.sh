#!/bin/sh
service rsyslog start
service cron start
bundle exec whenever -w
rake db:migrate
foreman start
