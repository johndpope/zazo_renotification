class Metric::Base
  include Chartkick::Helper

  def self.type
    :default
  end

  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def execute
    {}
  end
end
