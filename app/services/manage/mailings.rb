class Manage::Mailings
  attr_reader :form

  def initialize(raw_params)
    @params = raw_params
    @form   = MailingForm.new params
  end

  def run
    return false unless form.valid?
    phones.each do |phone|
      status = ::Message::SendSms.new(message, "+#{phone}").do ? :success : :fail
      Mailing.create mailing_attrs("+#{phone}", status)
    end
    true
  end

  private

  def message
    @message ||= Message.new body: form.text
  end

  def phones
    form.phones.split
  end

  def params
    @params.require(:mailing_form).permit(:key, :text, :phones)
  end

  def mailing_attrs(phone, status)
    { phone: phone, message: form.text, status: status, key: form.key }
  end
end
