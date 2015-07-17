class Metric::VerifiedAfterNthNotification < Metric::Base
  def self.type
    :histogram
  end

  def execute

  end

  private

  def data
    messages = Message.order(:send_at).pluck(:target, :send_at)
    messages.each_with_object({}) do |message, memo|
      memo[message[0]] ||= []
      memo[message[0]] << message[1]
    end
  end

  def results

  end
end
