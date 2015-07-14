FactoryGirl.define do
  factory :delayed_template do
    delay_hours '3'
    program

    factory(:sms_delayed_template)   { association :template, factory: :sms_template }
    factory(:email_delayed_template) { association :template, factory: :email_template }
  end
end
