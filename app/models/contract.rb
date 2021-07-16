class Contract < ApplicationRecord
  belongs_to :plan
  has_many :calls

  def usage_price
    return 0 if self.plan.free?

    base_price + call_price
  end

  private

  def base_price
    self.plan.price * self.users_quantity
  end

  def call_price
    self.calls.sum(&:duration) / 60
  end
end
