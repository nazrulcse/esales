ActiveAdmin.register Slider do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  controller do
    def permitted_params
      params.permit!
    end
  end


  form html: { multipart: true } do |f|
    f.semantic_errors

    f.inputs  do
      f.input :image
      f.input :header,:label => 'Title'
      f.input :header_bold,:label => 'Announcement'
      f.input :header_small,:label => 'Sort Details'
      f.input :off,:label => 'Off %'
      f.input :link,:label => 'More Information Link'
    actions
  end
  end


end
