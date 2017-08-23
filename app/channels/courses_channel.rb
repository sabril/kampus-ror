class CoursesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'course_list'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.broadcast_to(course, user)

  end
end
