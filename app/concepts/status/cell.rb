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
        unit: 'prg.' },
      total_users,
      messages_by_status(:in_queue),
      messages_by_status(:sent),
      messages_by_status(:canceled),
      messages_by_status(:error) ]
  end

  def status_items(program)
    [ title(program),
      total_users(program),
      messages_by_status(:in_queue, program),
      messages_by_status(:sent,     program),
      messages_by_status(:canceled, program),
      messages_by_status(:error,    program) ]
  end

  def title(program)
    { text: program.name,
      desc: program.setting.started ? 'active' : 'inactive' }
  end

  def total_users(program = nil)
    { text: messages(program).distinct.count(:target),
      desc: 'users' }
  end

  def messages_by_status(status, program = nil)
    { text: messages(program).send(status).count,
      link: program ? eval("#{status}_program_messages_path(program)") : eval("#{status}_messages_path"),
      desc: status.to_s,
      unit: 'msg.' }
  end

  def messages(program)
    program ? Message.where(program: program) : Message
  end
end
