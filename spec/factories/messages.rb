FactoryGirl.define do
  factory :message do
    target  { SecureRandom.hex }
    body    { Faker::Hacker.say_something_smart }
    send_at { Time.now + 1.hours }

    association :program
    association :delayed_template, factory: :sms_delayed_template
  end
end
