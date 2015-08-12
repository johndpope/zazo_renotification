class MessagesController < ApplicationController
  def in_queue
    handle_status :in_queue
  end

  def sent
    handle_status :sent
  end

  def canceled
    handle_status :canceled
  end

  def error
    handle_status :error
  end

  private

  def handle_status(status)
    @status   = status
    @messages = Message.send status
    render 'by_status'
  end
end
