class EventsApiFilter < BaseApi
  version  1
  base_uri Figaro.env.events_api_base_url
  prefix  'metrics/filter'
  action  :get
end
