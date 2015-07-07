class BaseApi
  attr_reader :connection

  class << self
    attr_reader :api_version,
                :api_base_uri,
                :api_prefix,
                :api_action

    def version(version)
      @api_version = version
    end

    def base_uri(uri)
      @api_base_uri = uri
    end

    def prefix(prefix)
      @api_prefix = prefix.to_s
    end

    def action(verb)
      @api_action = verb
    end
  end

  def initialize
    @connection = Faraday.new(self.class.api_base_uri) do |c|
      c.request  :json
      c.response :json, content_type: /\bjson$/
      c.response :raise_error
      c.adapter Faraday.default_adapter
    end
  end

  def data(id, options = {})
    connection.send(self.class.api_action, path(id), options).body
  end

  protected

  def namespace
    "api/v#{self.class.api_version}"
  end

  def path(id)
    File.join namespace, self.class.api_prefix, id.to_s
  end
end
