ActiveAdmin.register Travel do
  filter :vehicle
  filter :title
  filter :from_date
  filter :to_date
  filter :price
  filter :offer
  filter :location

  controller do
    defaults :finder => :find_by_slug
  end

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :title
    column :description
    column :from_date do |travel|
      travel.from_date.strftime('%b %d, %Y') if travel.from_date.present?
    end
    column :to_date do |travel|
      travel.to_date.strftime('%b %d, %Y') if travel.to_date.present?
    end
    column :location
    column :price do |product|
      number_to_currency product.price
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :vehicle
      row :from_date do |travel|
        travel.from_date.strftime('%b %d, %Y') if travel.from_date.present?
      end
      row :to_date do |travel|
        travel.to_date.strftime('%b %d, %Y') if travel.to_date.present?
      end
      row :location
      row :price do |product|
        number_to_currency product.price
      end
      row :is_ticket
      row :offer
      row :lat
      row :lng
      row :images do |travel|
        ul do
          travel.images.each do |image|
            li do
              image_tag image.img_url(:thumb)
            end
          end
        end
      end
      row :created_at
    end
  end

  form html: {multipart: true} do |f|
    f.semantic_errors
    render 'location', f: f
    f.inputs do
      f.input :title
      f.input :is_ticket, label: 'This is ticker?'
      f.input :description, input_html: {rows: 6}
      f.input :from_date, :as => :datepicker, hint: 'Only put from or to date for ticket'
      f.input :to_date, :as => :datepicker, hint: 'Only put from or to date for ticket'
      f.input :time
      f.input :vehicle, collection: Vehicle.all
      f.input :price
      f.input :offer
      f.input :location
      f.hidden_field :lat
      f.hidden_field :lng
      f.input :tag_list, :hint => 'Comma separated'
      f.has_many :images do |ff|
        ff.input :img, as: :file
      end
    end
    actions
  end
end

