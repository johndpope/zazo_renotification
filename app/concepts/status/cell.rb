class Status::Cell < Cell::Concept
  def show
    render
  end

  private

  def programs
    [total] + Program.all.map do |program|
      status_items program
    end
  end

  def total
    [ { text: Program.active.count,
        desc: 'active',
        unit: 'prg.'},
      messages_in_queue,
      messages_sent,
      messages_canceled,
      messages_error ]
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

  def messages_in_queue(program = nil)
    { text: messages(program).in_queue.count,
      link: program ? in_queue_program_messages_path(program) : in_queue_messages_path,
      desc: 'in queue',
      unit: 'msg.' }
  end

  def messages_sent(program = nil)
    { text: messages(program).sent.count,
      link: program ? sent_program_messages_path(program) : sent_messages_path,
      desc: 'sent',
      unit: 'msg.' }
  end

  def messages_canceled(program = nil)
    { text: messages(program).canceled.count,
      link: program ? canceled_program_messages_path(program) : canceled_messages_path,
      desc: 'canceled',
      unit: 'msg.' }
  end

  def messages_error(program = nil)
    { text: messages(program).error.count,
      link: program ? error_program_messages_path(program) : error_messages_path,
      desc: 'error',
      unit: 'msg.' }
  end

  def messages(program)
    program ? Message.where(program: program) : Message
  end
end
