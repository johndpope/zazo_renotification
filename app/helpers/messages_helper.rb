module MessagesHelper
  def messages_page_title(status, program = nil)
    title =  "#{status} messages"
    title += " by #{program.name} program" if program
    title
  end
end
