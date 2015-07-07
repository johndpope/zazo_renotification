class StatisticsApi < BaseApi
  version  1
  base_uri Figaro.env.statistics_api_base_url
  prefix  :filters
  action  :get
end
