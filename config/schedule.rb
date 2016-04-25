set :output, '/usr/src/app/log/cron.log'

[:PATH, :GEM_HOME, :RAILS_ENV,
 :db_name, :db_host, :db_port, :db_username, :db_password,
 :notification_api_base_url, :notification_api_token,
 :dataprovider_api_base_url, :dataprovider_api_token,
 :newrelic_license_key, :rollbar_access_token,
 :secret_key_base, :logstash_url].each { |key| env key, ENV[key.to_s] }

every 10.minutes do
  runner "TraceWrapper.trace('Renotification') { Renotification.execute }"
  runner "TraceWrapper.trace('Message::Worker') { Message::Worker.execute }"
end
