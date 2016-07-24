class WelcomeController < ApplicationController

  def index
    @top_products = Product.all.where(is_featured: true)
    @products = Product.all
    @categories = Category.all
    render layout: 'landing'
  end

  # def send
  #
  # end

  def product_details

  end

  def contact
    render 'contact_us'
  end

  def settings
    if current_user.present?
      @resource = current_user
    else
      redirect_to root_path
    end

  end

  def save_contact
    contact = Contact.new(name: params[:name], email: params[:email], subject: params[:subject], message: params[:message])
    if contact.save
      flash[:notice] = "Your Message has been send to Admin"
    else
      flash[:notice] = "Something worng please try again"
    end
    redirect_to contact_path
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
