class StatisticsApi < BaseApi
  version  1
  base_uri Figaro.env.statistics_api_base_url

  mapper filter:     { action: :get,  prefix: 'fetch/users' },
         fetch:      { action: :post, prefix: 'fetch/users' },
         attributes: { action: :get,  prefix: 'fetch/attributes' },
         country:    { action: :get,  prefix: 'fetch/country' },
         default:    { action: :get,  prefix: '' }
end
