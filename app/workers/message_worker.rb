class MessageWorker
  include Sidekiq::Worker

  def perform(message)
    Message::Send.new(message).now
  end
end
