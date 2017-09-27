class Api::V2::CoursesController < Api::ApplicationController
  def index
    json_response({message: "This is version 2"})
  end
end
