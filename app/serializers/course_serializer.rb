class CourseSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper
  attributes :id, :title, :description
  
  has_many :tasks
  
  def description
    strip_tags(object.description)
  end
end
