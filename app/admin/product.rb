ActiveAdmin.register Product do
  filter :name
  filter :category
  filter :brand
  filter :color
  filter :price
  filter :subscriber_discount
  filter :is_feature, label: 'Featured?'

  controller do
    defaults finder: :find_by_slug

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :name
    column :category
    column :subscriber_discount
    column :price do |product|
      number_to_currency product.price
    end
    column do |t|
      span link_to 'Make Featured', featured_admin_product_path(t) unless t.is_featured
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
      row :subscriber_discount
      row :color
      row :price do |product|
        number_to_currency product.price
      end
      row :images do
        ul do
          product.images.each do |image|
            li do
              image_tag(image.img.url(:thumb))
            end
          end
        end
      end
    end

    active_admin_comments
  end

  form html: {multipart: true} do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :description
      f.input :category
      f.input :subscriber_discount, :hint => '%'
      f.input :price
      f.input :tag_list, :hint => 'Comma separated'
      f.input :related_product, label: 'Related Services', collection: Product.all.where(product_type: 'product')
      f.input :brand
      f.input :color
      f.has_many :images, heading: 'Images' do |ff|
        ff.input :img, label: false
      end
    end
    actions
  end


  member_action :featured, method: :get do
    product = Product.find_by_slug(params[:id])
    product.is_featured = true
    product.save
    redirect_to admin_products_path, notice: "The product is now Featured product"
  end

  member_action :remove_featured, method: :get do
    product = Product.find_by_slug(params[:id])
    product.is_featured = false
    product.save
    redirect_to admin_products_path, notice: "Successfully Removed"
  end

end

