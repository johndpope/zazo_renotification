class Status::Cell < Cell::Concept
  def show
    render
  end

  private

  def status_items
    [ active_programs,
      messages_in_queue,
      messages_sent,
      messages_canceled,
      messages_error ]
  end

  def active_programs
    { count: Program.active.count,
      title: 'active',
      unit:  'prg.' }
  end

  def messages_in_queue
    { count: Message.in_queue.count,
      link:  in_queue_messages_path,
      title: 'in queue',
      unit:  'msg.' }
  end

  def messages_sent
    { count: Message.sent.count,
      link:  sent_messages_path,
      title: 'sent',
      unit:  'msg.' }
  end

  def messages_canceled
    { count: Message.canceled.count,
      link:  canceled_messages_path,
      title: 'canceled',
      unit:  'msg.' }
  end

  def messages_error
    { count: Message.error.count,
      link:  error_messages_path,
      title: 'error',
      unit:  'msg.' }
  end
end
