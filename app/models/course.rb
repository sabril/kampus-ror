class Course < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  
  has_attached_file :image, styles: { medium: "680x300>", thumb: "170x75>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
