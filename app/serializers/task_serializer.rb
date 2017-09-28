class TaskSerializer < ActiveModel::Serializer
  attributes :id, :course_id, :title, :description
end
