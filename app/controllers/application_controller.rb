class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_cart,:color_list
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

   def set_locale
    I18n.locale = session[:locale]|| I18n.default_locale
    end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def set_admin_locale
    I18n.locale = :en
  end


  def current_cart
    ShoppingCart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = ShoppingCart.create
    session[:cart_id] = cart.id
    cart
  end

  def color_list
    Product.uniq.pluck(:color)
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
