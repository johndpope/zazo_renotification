class StatisticsApi < BaseApi
  version     1
  base_uri    Figaro.env.statistics_api_base_url
  digest_auth APP_INFO['app_name_key'], Figaro.env.statistics_api_token

  mapper filter:     { action: :get,  prefix: 'fetch/users' },
         fetch:      { action: :post, prefix: 'fetch/users' },
         attributes: { action: :get,  prefix: 'fetch/attributes' },
         country:    { action: :get,  prefix: 'fetch/country' },
         default:    { action: :get,  prefix: '' }
end
