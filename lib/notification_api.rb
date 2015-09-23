class NotificationApi < BaseApi
  version     1
  base_uri    Figaro.env.notification_api_base_url
  digest_auth APP_INFO['app_name_key'], Figaro.env.notification_api_token

  raise_errors false

  mapper sms:     { action: :post, prefix: 'notifications/sms' },
         default: { action: :get,  prefix: '' }
end
