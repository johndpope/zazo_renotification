class MessageWorker
  include Sidekiq::Worker

  def perform(message)
    Message::Send.new(message.id).now
  end
end
