ActiveAdmin.register Booking do
  filter :name
  filter :email
  filter :mobile
  filter :quantity
  filter :created_at

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column :name
    column :email
    column :mobile
    column :quantity
    column :booking do |booking|
      booking.bookable_type.to_s
    end
    column :user do |booking|
      booking.user.present? ? booking.user.name : 'Guest'
    end
    column :created_at do |booking|
      booking.created_at.strftime('%b %d, %Y')
    end
    actions
  end
end

