class Message::Worker
  def self.execute
    Message.time_passed.each do |message|
      Message::Send.new(message).do
    end
  end
end
