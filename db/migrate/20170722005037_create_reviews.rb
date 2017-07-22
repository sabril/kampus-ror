class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.integer :star
      t.text :comment

      t.timestamps
    end
  end
end
