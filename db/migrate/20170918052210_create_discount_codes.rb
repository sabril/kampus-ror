class CreateDiscountCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :discount_codes do |t|
      t.string :name
      t.string :code
      t.string :discount_type, default: "percentage"
      t.integer :discount_value, default: 10
      t.date :expired_date, default: Date.today
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
