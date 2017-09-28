Types::TaskType = GraphQL::ObjectType.define do
  name "Task"
  field :id, types.ID
  field :title, types.String
  field :description, types.String
end
