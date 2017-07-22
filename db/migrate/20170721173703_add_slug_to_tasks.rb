class AddSlugToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :slug, :string
  end
end
