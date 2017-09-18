class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  
  def add_item(course_id)
    cart_items.find_or_create_by(course_id: course_id) 
  end
end
