class AddAttachmentImageToCourses < ActiveRecord::Migration[5.1]
  def self.up
    change_table :courses do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :courses, :image
  end
end
