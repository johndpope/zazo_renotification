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

    def initialize(params = [])
      set_params params
    end

    def execute
      []
    end

    private

    def set_params(params)
      self.class.params_map.each_with_index do |row, index|
        value = params[index].nil? ? row[:default] : row[:proc].call(params[index])
        instance_variable_set "@#{row[:instance]}", value
      end
    end
  end
end
