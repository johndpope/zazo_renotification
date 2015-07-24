FactoryGirl.define do
  factory :template do
    name  { SecureRandom.hex }
    title 'Hello!'
    body  '<%= friend.name %> sent you a message.'

    factory(:sms_template)   { kind 'sms' }
    factory(:email_template) { kind 'email' }
  end
end
