FactoryGirl.define do
  factory :program do
    name { SecureRandom.hex }

    trait :with_queries do
      after :create do |program|
        program.queries << Query::NotVerified.new
        program.queries << Query::NonMarketing.new
        program.save!
      end
    end

    trait :with_delayed_templates do
      after :create do |program|
        program.delayed_templates << FactoryGirl.create(:sms_delayed_template, delay_hours: '1')
        program.delayed_templates << FactoryGirl.create(:sms_delayed_template, delay_hours: '2')
        program.save!
      end
    end

    factory :program_with_queries, traits: [:with_queries]
    factory :program_with_templates, traits: [:with_delayed_templates]
    factory :program_with_dependencies, traits: [:with_queries, :with_delayed_templates]
  end
end
