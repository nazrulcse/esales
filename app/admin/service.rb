ActiveAdmin.register Service do
  filter :name, label: 'Name'
  filter :unit, label: 'Unit'
  filter :price, label: 'Price'
  filter :category, label: 'Category'
  filter :is_feature, label: 'Featured?'

  controller do
    defaults :finder => :find_by_slug

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :name
    column :category
    column :description
    column :unit
    column :price do |product|
      number_to_currency product.price
    end
    column do |t|
      span link_to 'Make Featured', featured_admin_service_path(t) unless t.is_featured
      span link_to 'Make Unfeatured', remove_featured_admin_service_path(t) if t.is_featured
    end
    actions
  end

  show do
    attributes_table do
      row :category
      row :name
      row :description
      row :price
      row :unit
      row :images do
        ul do
          service.images.each do |image|
            li do
              image_tag(image.img_url(:thumb))
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
      f.input :category, collection: Category.all
      f.input :name
      f.input :description, :input_html => {:rows => 6}
      f.input :price
      f.input :unit, collection: AppSetting::UNIT.collect { |key, val| [val, key] }
      f.input :relateds, label: 'Related Services', collection: Service.all
      f.input :tag_list, :hint => 'Comma separated'
      f.has_many :images do |ff|
        ff.input :img, as: :file
      end
    end
    actions
  end


  member_action :featured, method: :get do
    service = Service.find_by_slug(params[:id])
    service.update_attribute(:is_featured, true)
    redirect_to admin_services_path, notice: 'The service is now Featured product'
  end

  member_action :remove_featured, method: :get do
    service = Service.find_by_slug(params[:id])
    service.update_attribute(:is_featured, true)
    redirect_to admin_services_path, notice: 'Successfully Removed'
  end

end

