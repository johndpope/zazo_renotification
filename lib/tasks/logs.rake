namespace :logs do
  PROD_LOG_PATH    = Rails.root.join('log/production.log')
  EB_LOGS_PATH     = Rails.root.join('.elasticbeanstalk/logs/latest')
  CURRENT_APP_PATH = -> (id) { EB_LOGS_PATH.join(id).join('var/log/eb-docker/containers/eb-current-app') }

  desc 'Get production logs from Amazon and paste together into log/production.log'
  task :production do
    system 'eb logs -a > /dev/null 2>&1'
    if Dir.entries(EB_LOGS_PATH).size > 2
      instance_id      = Dir.entries(EB_LOGS_PATH).last
      current_app_path = CURRENT_APP_PATH.call instance_id
      puts "Instance found: #{instance_id}"

      system "gunzip #{current_app_path.join('rotated').join('production.log*.gz')}"
      system "cat    #{current_app_path.join('rotated').join('production.log*')} #{current_app_path.join('production.log')} > #{PROD_LOG_PATH}"
      puts "Production logs were saved to #{PROD_LOG_PATH}"
    else
      puts "No instances found in #{EB_LOGS_PATH}"
    end
  end
end
