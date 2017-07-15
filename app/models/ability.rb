class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, Task, preview: true
    can :read, Task, course: {id: user.course_ids }
  end
end
