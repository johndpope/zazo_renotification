class Metric::VerifiedAfterNthNotification < Metric::Base
  def self.type
    :histogram
  end

  def execute
    data = users_data
    return {} if data.empty?
    data = EventsApi.new(users_data: data).metric :verified_after_nth_notification
    data.keys.each_with_object({}) do |key, memo|
      memo[vx_title(key)] = (data[key].to_f / @total_users * 100).round 2
    end
  end

  private

  def messages_per_user
    messages = Message
    messages = messages.where(program_id: options[:program_id].to_i) if options[:program_id]
    messages = messages.order(:send_at).pluck(:target, :send_at)
    messages.each_with_object({}) do |message, memo|
      memo[message[0]] ||= []
      memo[message[0]] << message[1]
    end
  end

  def users_data
    data = messages_per_user
    @total_users = data.size
    data.keys.each_with_object([]) do |user, memo|
      data[user].each_with_index do |sent_at, index|
        if index == 0
          memo << user_data_row(user, 0, boundary_date(:-), sent_at)
        end
        next_sent_at = data[user][index + 1]
        next_sent_at = boundary_date(:+) if next_sent_at.nil?
        memo << user_data_row(user, index + 1, sent_at, next_sent_at)
      end
    end
  end

  def user_data_row(user, order, sent_at, next_sent_at)
    { user_id: user,    msg_order: order,
      sent_at: sent_at, next_sent_at: next_sent_at }
  end

  def boundary_date(sign)
    Time.now.send sign, 10.years
  end

  def vx_title(key)
    key.to_i == 0 ? 'before 1st' : "after #{key.to_i.ordinalize}"
  end
end
