class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def later
    #MessageWorker.perform_in 20.seconds, message
  end
end
