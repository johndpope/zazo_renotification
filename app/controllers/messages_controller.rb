class MessagesController < ApplicationController
  before_action :set_program

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
    @messages = Message
    @messages = @messages.where(program: @program) if @program
    @messages = @messages.send status
    render 'by_status'
  end

  def set_program
    program_id = params[:program_id]
    @program = Program.find(program_id) if program_id
  end
end
