include ActionView::Helpers::TextHelper

Types::CourseType = GraphQL::ObjectType.define do
  name "Course"
  field :id, types.ID
  field :title, types.String
  field :description, types.String do
    resolve ->(obj, args, ctx) {
      strip_tags(obj.description)
    }
  end
  field :tasks, types[Types::TaskType]
end
