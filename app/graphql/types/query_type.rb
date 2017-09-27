Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :course do
    description "Get course"
    type Types::CourseType
    
    argument :id, !types.String
    resolve ->(obj, args, ctx) {
      Course.find(args[:id])
    }
  end

  field :courses do
    description "Get all courses"
    type types[Types::CourseType]
    argument :page, types.String
    resolve ->(obj, args, ctx) {
      Course.page(args[:page]).per(1)
    }
  end
end
