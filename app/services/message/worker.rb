class Message::Worker
  def self.execute
    messages = Message.time_passed
    Zazo::Tool::Logger.info self, "executed for #{messages.size} message(s)."
    messages.each { |message| Message::Send.new(message).do }
  end
end
