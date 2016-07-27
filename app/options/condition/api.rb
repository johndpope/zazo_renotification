module Condition::Api
  def check(user, &block)
    block_given? ? handle(&block) : false
  end

  private

  def handle
    begin
      yield
    rescue Faraday::ClientError => e
      Zazo::Tool::Logger.info(self, "faraday exception; class: #{e.class}; response #{e.response[:body]}")
      false
    end
  end
end
