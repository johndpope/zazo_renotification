FactoryGirl.define do
  factory :template do
    name  SecureRandom.hex
    title 'Hello!'
    body  '<%= inviter %> sent you a message.'

    factory :sms_template do
      name SecureRandom.hex
      kind 'sms'
    end

    factory :email_template do
      name SecureRandom.hex
      kind 'email'
    end
  end
end
