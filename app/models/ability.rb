class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, Task, preview: true
    can :read, Task, course: {id: user.course_ids }
    can :manage, Review, course: {id: user.course_ids}, user_id: user.id
  end
end
