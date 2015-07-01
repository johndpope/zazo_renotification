FactoryGirl.define do
  factory :sequence do
    delay_hours  '3'

    factory(:sms_sequence)   { association :template, factory: :sms_template  }
    factory(:email_sequence) { association :template, factory: :email_template }
  end
end
