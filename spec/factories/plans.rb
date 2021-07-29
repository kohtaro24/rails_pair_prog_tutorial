FactoryBot.define do
  factory :plan do

  end

  factory :free_plan, class: Plan do
    id { Plan::FREE_PLAN_ID }
    title { "Free" }
    price { 0 }

    # 2回目以降でcreateが呼ばれた場合はfindしたものを返す
    initialize_with do
      Plan.find_or_initialize_by(id: Plan::FREE_PLAN_ID)
    end
  end

  factory :basic_plan, class: Plan do
    id { Plan::BASIC_PLAN_ID }
    title { "Basic" }
    price { 4800 }

    initialize_with do
      Plan.find_or_initialize_by(id: Plan::BASIC_PLAN_ID)
    end
  end
end
