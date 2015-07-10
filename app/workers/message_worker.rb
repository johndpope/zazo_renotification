class MessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'messages'

  def perform(message_id)
    Message::Send.new(message_id).now
  end
end
