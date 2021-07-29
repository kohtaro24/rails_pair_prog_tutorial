FactoryBot.define do
  factory :contract do
    name { FFaker::CompanyJA.name }

    trait :free do
      plan { FactoryBot.create(:free_plan) }
    end

    trait :basic do
      plan { FactoryBot.create(:basic_plan) }
    end

    transient do
      calls_size { 0 }
    end

    after(:build) do |contract, evaluator|
      evaluator.calls_size.times do
        contract.calls << FactoryBot.build(:call)
      end
    end
  end
end
