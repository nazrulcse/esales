class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_cart
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_cart
    ShoppingCart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = ShoppingCart.create
    session[:cart_id] = cart.id
    cart
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :image, :email, :password, :password_confirmation,:father_name, :mother_name, :date_of_birth, :permanent_address, :present_address, :voter_id, :mobile, :identifier_name, :identifier_mobile, :identifier_address, :user_type)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password)
    end
  end
end
