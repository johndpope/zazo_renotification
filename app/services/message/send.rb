class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def do
    unless check_program_exist
      WriteLog.debug self, "At #{Time.now} program was already soft-deleted. Message: #{message.inspect}."
      set_status :canceled
      return
    end

    if Condition::Check.new(message.target, message.program).do
      klass = Classifier.new([:message, "send_#{message.kind}"]).klass
      set_status klass.new(message).do ? :sent : :error
    else
      set_status :canceled
    end
    WriteLog.debug self, "At #{Time.now} was trying to send: #{message.inspect}."
  end

  private

  def set_status(status)
    message.update_attributes status: status
  end

  def check_program_exist
    program = message.program
    Program.find_by_id(program.id) ? true : false
  end
end
