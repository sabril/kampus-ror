class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.money :price
      t.string :status
      t.string :image

      t.timestamps
    end
  end
end
