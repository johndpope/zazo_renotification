class EventsApi
  API_VERSION = 1

  attr_reader :connection

  def api_base_url
    Figaro.env.events_api_base_url
  end

  def initialize
    @connection = Faraday.new(api_base_url) do |c|
      c.request  :json
      c.response :json, content_type: /\bjson$/
      c.response :raise_error
      c.adapter Faraday.default_adapter
    end
  end

  def namespace
    "api/v#{API_VERSION}"
  end

  def filter_path(filter)
    File.join(namespace, 'metrics/filter', filter.to_s)
  end

  def filter_data(filter, options = {})
    @connection.post(filter_path(filter), options).body
  end
end
