class AddPreviewToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :preview, :boolean, default: false
  end
end
