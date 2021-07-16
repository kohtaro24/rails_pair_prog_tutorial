class Plan < ApplicationRecord
  FREE_PLAN_ID = 1
  BASIC_PLAN_ID = 2
  has_many :contracts

  def self.suggest_plan_id(contract)
    if contract.users_quantity > 5
      BASIC_PLAN_ID
    else
      FREE_PLAN_ID
    end
  end

  def free?
    self.id == FREE_PLAN_ID
  end
end
