class CourseSerializer < ActiveModel::Serializer
	include ActionView::Helpers::SanitizeHelper
  attributes :id, :title, :description
  has_many :tasks

  def description
  	strip_tags(object.description).squeeze(' ').gsub(/, /, ',').gsub(/[^0-9A-Za-z,\r\n ]/i, '').strip
  end

  def title
  	object.title.squeeze(' ').gsub(/, /, ',').gsub(/[^0-9A-Za-z,\r\n ]/i, '').strip
  end
end
