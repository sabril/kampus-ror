ActiveAdmin.register Task do
  permit_params :course_id, :title, :description, :video_url, :image

end
