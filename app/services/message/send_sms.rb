class Message::SendSms
  attr_reader :message, :mobile

  def initialize(message, mobile = nil)
    @message = message
    @mobile  = mobile || mobile_number
  end

  def do(options = {})
    return true unless options[:force] || Rails.env.production?
    response = NotificationApi.new(mobile_number: mobile, body: message.body).sms

    if response['status'] == 'success'
      WriteLog.debug self, "Message was sent to #{mobile} at #{Time.now}. Message: #{message.inspect}."
      true
    else
      WriteLog.debug self, "Error occurred while sending message to #{mobile} at #{Time.now}. Errors: #{response['errors']}. Message: #{message.inspect}."
      false
    end
  end

  private

  def mobile_number
    response = StatisticsApi.new(user: message.target, attrs: [:mobile_number]).attributes
    response['mobile_number']
    :none
  end
end