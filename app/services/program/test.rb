class Program::Test
  attr_reader :program, :phone, :email

  def initialize(program, test_data)
    @program = program
    @phone   = test_data[:phone]
    @email   = test_data[:email]
  end

  def sms
    delayed_templates['sms'].each do |dt|
      Message::SendSms.new(build_message(dt), phone).do force: true
    end
  end

  def email
    delayed_templates['email'].each do |dt|
    end
  end

  private

  def delayed_templates
    @dt ||= program.grouped_delayed_templates
  end

  def build_message(dt)
    data = Template::Compiler.new(nil).send :preview_data
    Manage::Message.new(data: data, program: program, delayed_template: dt).build
  end
end
