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
      Zazo::Tools::Logger.info(self, "success; mobile: #{mobile}; message: #{message.to_json}")
      true
    else
      Zazo::Tools::Logger.info(self, "failure, mobile: #{mobile}; errors: #{response['errors']}; message: #{message.inspect}")
      false
    end
  end

  private

  def mobile_number
    # StatisticsApi.new(users: @users).filter :specific_users
    # todo: check specs
    response = DataProviderApi.new(user: message.target, attrs: [:mobile_number]).query :attributes
    Rails.env.production? ? response['mobile_number'] : :none # it's just a paranoia
  end
end
