ActiveAdmin.register Travel do

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
    column :from_date
    column :to_date
    column :location
    column :price do |product|
      number_to_currency product.price
    end
    actions
  end

  form html: {multipart: true} do |f|
    f.semantic_errors
    render 'location', f: f
    f.inputs do
      f.input :title
      f.input :description
      f.input :from_date
      f.input :to_date
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

