class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def now
    puts '!!!MESSAGE!!!'
    p message
  end

  def later
    MessageWorker.perform_at message.send_at, message.id
  end
end
