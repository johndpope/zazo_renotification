class StatisticsApi < BaseApi
  version  1
  base_uri Figaro.env.statistics_api_base_url

  mapper not_verified: { action: :get,  prefix: 'fetch/users' },
         names:        { action: :post, prefix: 'fetch/users' },
         default:      { action: :get,  prefix: 'fetch' }
end
