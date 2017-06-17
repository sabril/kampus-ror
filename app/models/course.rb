class Course < ApplicationRecord
    has_many :tasks, dependent: :destroy
end
