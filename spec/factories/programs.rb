FactoryGirl.define do
  factory :program do
    name { SecureRandom.hex }

    trait :with_queries do
      after(:create) do |program|
        program.queries << Query::NotVerified.new
        program.queries << Query::NonMarketing.new
        program.save!
      end
    end

    factory :program_with_queries, traits: [:with_queries]
  end
end
