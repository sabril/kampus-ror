class DiscountCode < ApplicationRecord
  validates_presence_of :name, :code
  validates_uniqueness_of :code
  
  def discount_total(total)
    total - (total * discount_percentage.to_f / 100)
  end
end
