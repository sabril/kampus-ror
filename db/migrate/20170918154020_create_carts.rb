class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true
      t.boolean :completed, default: true
      t.decimal :total, default: 0.0

      t.timestamps
    end
  end
end
