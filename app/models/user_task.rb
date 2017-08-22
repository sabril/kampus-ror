class UserTask < ApplicationRecord
  belongs_to :user
  belongs_to :task
  
  scope :completed, ->{ where(completed: true) }
end
