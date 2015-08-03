class NotificationApi < BaseApi
  version    1
  base_uri   Figaro.env.notification_api_base_url
  auth_token Figaro.env.notification_api_token

  raise_errors false

  mapper sms:     { action: :post, prefix: 'notifications/sms' },
         default: { action: :get,  prefix: '' }
end
