class MessageWorker
  include Sidekiq::Worker

  def perform(text)
    puts "Message sent: #{text}"
  end
end
