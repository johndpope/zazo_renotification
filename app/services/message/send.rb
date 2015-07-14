class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def do
    if Condition::Check.new(message.target, message.program).do
      # send message with another service
      message.update_attributes status: :sent
    else
      message.update_attributes status: :canceled
    end
    Rails.logger.tagged('Message::Send') { Rails.logger.debug message }
  end
end
