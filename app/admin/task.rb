ActiveAdmin.register Task do
  permit_params :course_id, :title, :description, :video_url, :image, :preview
  
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
