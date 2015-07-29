class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def do
    if Condition::Check.new(message.target, message.program).do
      klass = Classifier.new([:message, "send_#{message.kind}"]).klass
      set_status klass.new(message).do ? :sent : :error
    else
      set_status :canceled
    end
    Rails.logger.tagged('Message::Send') { Rails.logger.debug message }
  end

  private

  def set_status(status)
    message.update_attributes status: status
  end
end
