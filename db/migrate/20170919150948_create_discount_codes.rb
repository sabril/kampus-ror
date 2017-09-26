class CreateDiscountCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :discount_codes do |t|
      t.string :name
      t.string :code
      t.integer :discount_percentage, default: 10
      t.date :expired_date, default: Date.today + 14.days
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
