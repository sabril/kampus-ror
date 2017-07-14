class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.boolean :active, default: false

      t.timestamps
    end
    
    add_index :subscriptions, [:user_id, :course_id]
  end
end
