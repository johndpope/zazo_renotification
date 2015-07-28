class BaseApi
  class << self
    attr_reader :api_version,
                :api_base_uri,
                :api_auth_token,
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

    def auth_token(token)
      @api_auth_token = token
    end
  end

  attr_reader :connection, :options

  def initialize(options = {})
    @options = options
    @connection = Faraday.new(self.class.api_base_uri) do |c|
      c.request  :json
      c.response :json, content_type: /\bjson$/
      c.response :raise_error
      c.request(:digest, 'renotification', auth_token) if auth_token
      c.adapter Faraday.default_adapter
    end
  end

  def method_missing(method, *args)
    if map.key? method
      connection.send(*params(method, args[0]), options).body
    else
      connection.send(*params(:default, args[0]), options).body
    end
  end

  protected

  def map
    self.class.api_map
  end

  def auth_token
    token = self.class.api_auth_token
    token ? URI::encode(token) : nil
  end

  def params(method, name)
    [map[method][:action], path(map[method][:prefix], name)]
  end

  def namespace
    "api/v#{self.class.api_version}"
  end

  def path(prefix, name)
    File.join [namespace, prefix, name].compact.map &:to_s
  end
end
