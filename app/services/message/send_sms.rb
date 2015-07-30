class Message::SendSms
  attr_reader :message, :mobile

  def initialize(message, mobile = nil)
    @message = message
    @mobile  = mobile || mobile_number
  end

  def do(options = {})
    return true unless options[:force] || Rails.env.production?
    NotificationApi.new(mobile_number: mobile, body: message.body).sms
    Rails.logger.tagged('Message::SendSms') { Rails.logger.debug "Message was sent to #{mobile} at #{Time.now}. Message: #{message.inspect}" }
    true
  rescue Faraday::ClientError # todo: log errors
    false
  end

  private

  def mobile_number
    response = StatisticsApi.new(user: message.target, attrs: [:mobile_number]).attributes
    response['mobile_number']
    :none
  end
end
