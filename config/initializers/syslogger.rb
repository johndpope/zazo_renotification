# Using papertrailapp.com for app logs management

def Rails.syslogger
  RemoteSyslogLogger.new(ENV['papertrail_host'], ENV['papertrail_port'], program: 'zazo-renotification')
end
