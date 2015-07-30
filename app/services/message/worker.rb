class Message::Worker
  def self.execute
    messages = Message.time_passed
    Rails.logger.tagged('Message::Worker') { Rails.logger.debug "Was executed at #{Time.now} with #{messages.size} message(s)." }
    messages.each { |message| Message::Send.new(message).do }
  end
end
