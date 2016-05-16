class WelcomeController < ApplicationController

  def index
    @top_products = Product.all.where(is_featured: true)
    @products = Product.all
    @categories = Category.all
    render layout: 'landing'

  end

  def product_details

  end



  def user_authentication
    @status = 'Success'
    user = User.find_by_email(params[:user][:email])
    if user.present?
      if user.valid_password?(params[:user][:password])
        sign_in user, :bypass => true
      else
        @status = 'Invalid Password'
      end
    else
      @status = 'Invalid Email'
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
