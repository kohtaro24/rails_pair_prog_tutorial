class Plan < ApplicationRecord
  has_many :contracts

  def free?
    self.id == 1
  end
end
