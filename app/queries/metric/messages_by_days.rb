class Metric::MessagesByDays < Metric::Base
  def self.type
    :line_chart
  end

  def execute
    [:sent, :error, :canceled].map do |status|
      { name: status, data: data_by_status(status) }
    end
  end

  private

  def data_by_status(status)
    messages = Message
    messages = messages.where(program_id: options[:program_id].to_i) if options[:program_id]
    messages.where(status: status).group_by_day(:send_at).count
  end
end
