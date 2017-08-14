class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :course
  acts_as_list scope: :course
  has_many :user_tasks, dependent: :destroy
  
  def next_task(tasks)
    tasks.where("position > ?", position).first  
  end
  
  def previous_task(tasks)
    tasks.where("position < ?", position).last
  end
end
