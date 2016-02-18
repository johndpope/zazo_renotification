# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, '/usr/src/app/log/cron.log'

[ :PATH, :GEM_HOME, :RACK_ENV,
  :db_name, :db_host, :db_port, :db_username, :db_password,
  :notification_api_base_url, :notification_api_token,
  :dataprovider_api_base_url, :dataprovider_api_token,
  :newrelic_license_key, :rollbar_access_token,
  :secret_key_base,
  :papertrail_host, :papertrail_port
].each { |key| env key, ENV[key.to_s] }

every 10.minutes do
  runner 'Renotification.execute'
  runner 'Message::Worker.execute'
end
