class CartItem < ApplicationRecord
  belongs_to :course
  belongs_to :cart
end
