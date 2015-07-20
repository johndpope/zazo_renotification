class Metric::Base
  include Chartkick::Helper

  def self.type
    :default
  end

  def execute
    {}
  end
end
