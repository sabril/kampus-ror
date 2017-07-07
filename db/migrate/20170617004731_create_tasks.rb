class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :course, foreign_key: true
      t.string :title
      t.text :description
      t.string :video_url
      t.string :image

      t.timestamps
    end
  end
end
