include ActionView::Helpers::SanitizeHelper

Types::CourseType = GraphQL::ObjectType.define do
  name "Course"
  field :id, types.ID
  field :title, types.String do
  	resolve ->(obj, args, ctx) do
  		strip_tags(obj.title).squeeze(' ').gsub(/, /, ',').gsub(/[^0-9A-Za-z,\r\n ]/i, '').strip
  	end
  end
  field :description, types.String do
  	resolve ->(obj, args, ctx) do
  		strip_tags(obj.description).squeeze(' ').gsub(/, /, ',').gsub(/[^0-9A-Za-z,\r\n ]/i, '').strip
  	end
  end
  field :tasks do
  	type types[Types::TaskType]
  end
end
