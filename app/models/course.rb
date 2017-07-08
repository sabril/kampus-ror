class Course < ApplicationRecord
  has_many :tasks, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
