class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.references :course, foreign_key: true
      t.references :cart, foreign_key: true
      t.decimal :sub_total, default: 0.0

      t.timestamps
    end
  end
end
