ActiveAdmin.register Service do

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
  permit_params :name, :description,:image,:price,:unit

  form html: { multipart: true } do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :description
      f.input :image
      f.input :price
      f.input :unit, :as => :select, :collection => [ ["Day", 'day'], ["Hour", 'hour']]
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price do |product|
        number_to_currency product.price
      end
      row :unit
      row :images do |image|
        image_tag(image.image.url(:thumb))
      end
    end

    active_admin_comments
  end

end
