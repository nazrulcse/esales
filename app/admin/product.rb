ActiveAdmin.register Product do

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


  ActiveAdmin.register Product do
    # permit_params :category_id, :price,:brand_id, :color, :name, :description, :product_images_attributes

    index do
      selectable_column
      column :name
      column :category
      column :price do |product|
        number_to_currency product.price
      end
      actions
    end

    show do
      attributes_table do
        row :name
        row :description
        row :category
        row :brand
        row :color
        row :price do |product|
          number_to_currency product.price
        end
        row :images do
          ul do
            product.product_images.each do |image|
              li do
                image_tag(image.image.url(:thumb))
              end
            end
          end
        end
      end

      active_admin_comments
    end

    form html: { multipart: true } do |f|
      f.semantic_errors

      f.inputs do
          f.input :name
          f.input :description
        end

      f.inputs do
        f.input :category
        f.input :brand
        f.input :color,input_html: { type: "text" }
        f.input :price
        f.has_many :product_images do |ff|
          ff.input :image
        end
      end

      actions
    end
  end


end
