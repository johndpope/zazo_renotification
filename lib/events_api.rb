class EventsApi < BaseApi
  version  1
  base_uri Figaro.env.events_api_base_url

  mapper filter:  { action: :get,  prefix: 'metrics/filter' },
         metric:  { action: :post, prefix: 'metrics' },
         default: { action: :get,  prefix: '' }
end
