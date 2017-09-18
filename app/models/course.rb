class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  
  # has_attached_file :image, styles: { medium: "680x300>", thumb: "170x75>" }
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  mount_uploader :image, ImageUploader
  
  def average_rating
    reviews.blank? ? 0 : reviews.average(:star).round(2)
  end
  
  def paypal_link(user)
    subscription = Subscription.find_or_create_by(user: user, course_id: id)
    {
      :business => Rails.application.secrets.paypal_email,
      :cmd => "_xclick",
      :upload => 1,
      :amount => price,
      :notify_url => "https://kampus-ror-sabril.c9users.io/payment_notification",
      :item_name => title,
      :item_number => subscription.id,
      :quantity => 1,
      :return => "https://kampus-ror-sabril.c9users.io/my_courses"
    }.to_query
  end
  
  def user_progress(user)
    tasks.length > 0 ? (user.user_tasks.completed.where(task_id: task_ids).length * 100 / tasks.length) : 0
  end
end
