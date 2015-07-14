FactoryGirl.define do
  factory :user_data, class: Hash do
    mkey      { SecureRandom.hex }
    user      { Faker::Name.name }
    friend    { Faker::Name.name }
    time_zero { Time.now }

    initialize_with { attributes.stringify_keys }
  end
end
