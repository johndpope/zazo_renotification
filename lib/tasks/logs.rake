namespace :logs do
  PROD_LOG_PATH    = Rails.root.join('log/production.log')
  EB_LOGS_PATH     = Rails.root.join('.elasticbeanstalk/logs/latest')
  CURRENT_APP_PATH = EB_LOGS_PATH.join(Dir.entries(EB_LOGS_PATH).last).join('var/log/eb-docker/containers/eb-current-app')

  desc 'Get production logs from Amazon and paste together into log/production.log'
  task :production do
    system 'eb logs -a > /dev/null 2>&1'
    system "gunzip #{CURRENT_APP_PATH.join('rotated').join('production.log*.gz')}"
    system "cat    #{CURRENT_APP_PATH.join('rotated').join('production.log*')} #{CURRENT_APP_PATH.join('production.log')} > #{PROD_LOG_PATH}"
    puts "Production logs were saved to #{PROD_LOG_PATH}"
  end
end
