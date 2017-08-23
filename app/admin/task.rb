ActiveAdmin.register Task do
  permit_params :course_id, :title, :description, :video_url, :image, :preview, :position

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  member_action :sort, method: :post do
    resource.set_list_position(params[:position])
  end

  member_action :move_to_top, method: :post do
    resource.move_to_top
    redirect_to admin_course_path(resource.course), notice: "#{resource.title} task moved to top."
  end

  form do |f|
    f.inputs do
      f.input :course
      f.input :title
      f.input :description, as: :html_editor
      f.input :video_url
      f.input :image, hint: task.image.present? ? image_tag(task.image.url, height: 100) : content_tag(:span, 'No Image')
      f.input :preview
    end
    f.actions
  end
end
