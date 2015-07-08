class StatisticsApiFilter < BaseApi
  version  1
  base_uri Figaro.env.statistics_api_base_url
  prefix  'fetch/filter'
  action  :get
end
