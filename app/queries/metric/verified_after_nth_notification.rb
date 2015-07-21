class Metric::VerifiedAfterNthNotification < Metric::Base
  def self.type
    :histogram
  end

  def execute
    return {} if users_data.empty?
    data = EventsApi.new(users_data: users_data).metric :verified_after_nth_notification
    data.keys.each_with_object({}) do |key, memo|
      memo[key.to_i] = data[key].to_f / @total_users * 100
    end
  end

  private

  def messages_per_user
    messages = Message.order(:send_at).pluck(:target, :send_at)
    messages.each_with_object({}) do |message, memo|
      memo[message[0]] ||= []
      memo[message[0]] << message[1]
    end
  end

  def users_data
    return @users_data if @users_data
    data = messages_per_user
    @total_users = data.size
    @users_data  = data.keys.each_with_object([]) do |user, memo|
      data[user].each_with_index do |message, index|
        next_sent_at = data[user][index + 1]
        next_sent_at = Time.now + 10.years if next_sent_at.nil?
        memo << { user_id: user,    msg_order: index + 1,
                  sent_at: message, next_sent_at: next_sent_at }
      end
    end
  end
end
