class EventsApi < BaseApi
  version  1
  base_uri Figaro.env.events_api_base_url

  mapper default: { action: :get, prefix: 'metrics/filter' }
end
