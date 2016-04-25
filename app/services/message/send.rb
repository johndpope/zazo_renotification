class Message::Send
  attr_reader :message

  def initialize(message)
    @message = message.kind_of?(Message) ? message : Message.find(message)
  end

  def do
    unless check_program_exist
      Zazo::Tools::Logger.info(self, "program was already soft-deleted; message: #{message.to_json}")
      set_status :canceled
      return
    end

    if Condition::Check.new(message.target, message.program).do
      klass = Classifier.new([:message, "send_#{message.kind}"]).klass
      set_status klass.new(message).do ? :sent : :error
    else
      set_status :canceled
    end

    Zazo::Tools::Logger.info(self, "was trying to send message; message: #{message.to_json}")
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
