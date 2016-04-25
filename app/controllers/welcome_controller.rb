class WelcomeController < ApplicationController

  def index
    @top_products = Product.all.limit(2)
    @products = Product.all

  end

  def product_details

  end
end
