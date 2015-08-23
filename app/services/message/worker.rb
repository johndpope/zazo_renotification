class Message::Worker
  def self.execute
    messages = Message.time_passed
    WriteLog.info self, "Was executed at #{Time.now} with #{messages.size} message(s)."
    messages.each { |message| Message::Send.new(message).do }
  end
end
