FactoryBot.define do
  factory :contract do
    name { FFaker::CompanyJA.name }

    trait :free do
      plan { FactoryBot.create(:free_plan) }
    end

    trait :basic do
      plan { FactoryBot.create(:basic_plan) }
    end
  end
end
