class Status::Cell < Cell::Concept
  def show
    render
  end

  private

  def status_items
    [ active_programs,
      messages_in_queue,
      messages_sent,
      messages_canceled ]
  end

  def active_programs
    { count: Program.active.count,
      title: 'active',
      unit:  'prg.' }
  end

  def messages_in_queue
    { count: Message.in_queue.count,
      title: 'in queue',
      unit:  'msg.' }
  end

  def messages_sent
    { count: Message.sent.count,
      title: 'sent',
      unit:  'msg.' }
  end

  def messages_canceled
    { count: Message.canceled.count,
      title: 'canceled',
      unit:  'msg.' }
  end
end
