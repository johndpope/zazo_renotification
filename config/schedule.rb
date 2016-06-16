ENV_VARIABLES = [
  :PATH, :GEM_HOME, :RACK_ENV, :RAILS_ENV,
  :db_name, :db_host, :db_port, :db_username, :db_password,
  :notification_api_base_url, :notification_api_token,
  :dataprovider_api_base_url, :dataprovider_api_token,
  :newrelic_license_key, :rollbar_access_token,
  :logstash_url, :logstash_username, :logstash_password,
  :secret_key_base
]

set :output, '/usr/src/app/log/cron.log'

ENV_VARIABLES.each { |key| env key, ENV[key.to_s] }

every 10.minutes do
  runner "TraceWrapper.trace('Renotification') { Renotification.execute }"
  runner "TraceWrapper.trace('Message::Worker') { Message::Worker.execute }"
end
