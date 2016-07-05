class Metric::VerifiedAfterNthNotification < Metric::Base
  BATCH_SIZE = 1000

  def self.type
    :histogram
  end

  def execute
    total = { verified: 0, percent: 0.0 }
    total_users = users_messages.size
    metric_data.keys.each_with_object({}) do |key, memo|
      percent = metric_data[key].to_f / total_users * 100
      total[:verified] += metric_data[key].to_i
      total[:percent]  += percent
      memo["#{vx_title(key)} [#{metric_data[key]}]"] = percent.round(2)
    end.merge("total [#{total[:verified]}]" => total[:percent].round(2)).sort.to_h
  rescue Faraday::ClientError
    { 'data not presented' => 0 }
  end

  private

  def metric_data
    return @metric_data if @metric_data
    metric_data_batches = []
    while users_data = next_users_data do
      metric_data_batches << DataProviderApi.new(users_data: users_data).metric(:verified_after_nth_notification)
    end
    @metric_data ||= merge_metric_data_batches(metric_data_batches)
  end

  def merge_metric_data_batches(batches)
    batches.each_with_object({}) do |batch, memo|
      batch.each { |key, value| memo[key] ||= 0; memo[key] += value }
    end
  end

  def next_users_data
    @current_batch ||= 0
    users_messages = users_messages_by_batch(@current_batch)
    @current_batch += 1
    users_messages && prepare_users_data(users_messages)
  end

  def users_messages
    return @users_messages if @users_messages
    messages = Message
    messages = messages.where(program_id: options[:program_id].to_i) if options[:program_id]
    messages = messages.order(:send_at).pluck(:target, :send_at)
    @users_messages = messages.each_with_object({}) do |message, memo|
      memo[message[0]] ||= []
      memo[message[0]] << message[1]
    end
  end

  def users_messages_by_batch(batch)
    users = users_messages.keys[(batch * BATCH_SIZE)...((batch + 1) * BATCH_SIZE)]
    users && users_messages.slice(*users)
  end

  def prepare_users_data(data)
    data.keys.each_with_object([]) do |user, memo|
      data[user].each_with_index do |sent_at, index|
        memo << user_data_row(user, 0, boundary_date(:-), sent_at) if index == 0
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
    Time.now.send(sign, 10.years)
  end

  def vx_title(key)
    key.to_i == 0 ? 'before 1st' : "after #{key.to_i.ordinalize}"
  end
end
