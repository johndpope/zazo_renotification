FactoryGirl.define do
  factory :template do
    name  { SecureRandom.hex }
    title 'Hello!'
    body  '<%= friend.name %> sent you a message.'

    trait(:sms)   { kind 'sms' }
    trait(:email) { kind 'email' }

    trait :localized do
      after :create do |template|
        create :localized_template, template: template
      end
    end

    factory :sms_template,       traits: [:sms]
    factory :email_template,     traits: [:email]
    factory :template_localized, traits: [:sms, :localized]
  end
end
