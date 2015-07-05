FactoryGirl.define do
  factory :program do
    name { SecureRandom.hex }
  end
end
