class BaseApi
  class << self
    attr_reader :api_version,
                :api_base_uri,
                :api_map

    def version(version)
      @api_version = version
    end

    def base_uri(uri)
      @api_base_uri = uri
    end

    def mapper(map)
      @api_map = map
    end
  end

  attr_reader :connection, :options

  def initialize(options = {})
    @options = options
    @connection = Faraday.new(self.class.api_base_uri) do |c|
      c.request  :json
      c.response :json, content_type: /\bjson$/
      c.response :raise_error
      c.adapter Faraday.default_adapter
    end
  end

  def fetch(name)
    if map.key? name
      connection.send(*params(name), options).body
    else
      connection.send(*params(:default, name), options).body
    end
  end

  protected

  def map
    self.class.api_map
  end

  def params(key, method = nil)
    method = key if method.nil?
    method = map[key][:name] if map[key].key? :name
    [map[key][:action], path(map[key][:prefix], method)]
  end

  def namespace
    "api/v#{self.class.api_version}"
  end

  def path(prefix, name)
    File.join namespace, prefix, name.to_s
  end
end
