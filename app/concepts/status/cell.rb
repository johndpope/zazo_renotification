class Status::Cell < Cell::Concept
  def show
    render
  end

  private

  def programs
    Program.all.map do |program|
      status_items program
    end
  end

  def status_items(program)
    [ title(program),
      messages_in_queue(program),
      messages_sent(program),
      messages_canceled(program),
      messages_error(program) ]
  end

  def title(program)
    { text: program.name,
      desc: program.setting.started ? 'active' : 'inactive' }
  end

  def messages_in_queue(program)
    { text: messages(program).in_queue.count,
      link: in_queue_program_messages_path(program),
      desc: 'in queue',
      unit: 'msg.' }
  end

  def messages_sent(program)
    { text: messages(program).sent.count,
      link: sent_program_messages_path(program),
      desc: 'sent',
      unit: 'msg.' }
  end

  def messages_canceled(program)
    { text: messages(program).canceled.count,
      link: canceled_program_messages_path(program),
      desc: 'canceled',
      unit: 'msg.' }
  end

  def messages_error(program)
    { text: messages(program).error.count,
      link: error_program_messages_path(program),
      desc: 'error',
      unit: 'msg.' }
  end

  def messages(program)
    Message.where program: program
  end
end
