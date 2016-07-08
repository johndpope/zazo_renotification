class Metric::VerifiedAfterNthNotification < Metric::Base
  def self.type
    :histogram
  end

  def execute
    format_results(prepare_results)
  rescue Faraday::ClientError
    { 'data not presented' => 0 }
  end

  private

  def prepare_results
    users_data.each_with_object([]) do |row, memo|
      mkey, verified_at = row['mkey'], row['verified_at']
      if verified_at
        order = users_messages[mkey].select { |send_at| send_at.to_time < Time.parse(verified_at) }.size
        memo[order] = memo[order] ? memo[order] + 1 : 1
      end
    end
  end

  def format_results(results)
    total_users = users_messages.size
    total_verified = 0
    (0...results.size).each_with_object({}) do |order, memo|
      count = results[order] || 0
      percent = count.to_f / total_users * 100
      total_verified += count
      memo["#{vx_title(order)} [#{count}]"] = percent.round(2)
    end.merge("total [#{total_verified}]" => (total_verified.to_f / total_users * 100).round(2))
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

  def users_data
    @users_data ||= DataProviderApi.new(
      users: users_messages.keys,
      attrs: %w(mkey verified_at)).query_post(:attributes)
  end

  def vx_title(key)
    key.to_i == 0 ? 'before 1st' : "after #{key.to_i.ordinalize}"
  end
end
