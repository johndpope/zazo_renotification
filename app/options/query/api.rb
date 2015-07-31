module Query::Api
  extend ActiveSupport::Concern

  included do
    class << self
      def params(map)
        @params_map = map
      end

      def params_map
        @params_map || []
      end
    end

    def execute
      []
    end

    def init_params
      attrs = params.split(',')
      if attrs.size != self.class.params_map.size
        fail Query::ArgumentError, "wrong number of arguments (#{attrs.size} for #{self.class.params_map.size})"
      end
      self.class.params_map.each_with_index do |row, index|
        value = attrs[index].nil? ? row[:default] : row[:proc].call(attrs[index])
        instance_variable_set "@#{row[:instance]}", value
      end
    rescue => e
      raise Query::ArgumentError, "Attempt to pass incorrect params to #{self.class.name}. Original error: #{e.message}."
    end
  end
end
