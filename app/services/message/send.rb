class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def now
    if Condition::Check.new(message.target, message.program).do
      message.update_attributes is_sent: true
    else
      message.update_attributes is_sent: false
    end
    Rails.logger.tagged('Message::Send') { Rails.logger.debug message }
  end

  def later
    MessageWorker.perform_at message.send_at, message.id
  end
end
