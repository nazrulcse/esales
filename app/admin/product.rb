ActiveAdmin.register Product do

  # before_filter do
  #   Product.class_eval do
  #     def to_param
  #       if caller.to_s.include?"active_admin"
  #         id && id.to_s
  #       else
  #         slug
  #       end
  #     end
  #   end
  # end

  controller do
    defaults :finder => :find_by_slug
  end

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
      column do |t|
        span link_to 'Make Featured',   featured_admin_product_path(t) unless t.is_featured
        span link_to 'Make Unfeatured', remove_featured_admin_product_path(t) if t.is_featured
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
        f.input :color
        f.input :price
        f.input :tag_list, :hint => 'Comma separated'
        f.has_many :product_images do |ff|
          ff.input :image
        end
        f.input :related_product
      end

      actions
    end
  end


  member_action :featured, method: :get do
    product = Product.find_by_id(params[:id])
    product.is_featured = true
    product.save
    redirect_to admin_products_path, notice: "The product is now Featured product"
  end

  member_action :remove_featured, method: :get do
    product = Product.find_by_id(params[:id])
    product.is_featured = false
    product.save
    redirect_to admin_products_path, notice: "Successfully Removed"
  end

end
