class AddDiscountCodeToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :discount_code, :string
  end
end
