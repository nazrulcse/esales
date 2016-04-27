class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]

  def new
    @line_item = LineItem.new
  end

  def create
    @cart = current_cart
    quantity = params[:line_item].present? ? params[:line_item][:quantity] : 1
    @line_item = @cart.add_product(params[:product_id], quantity)
    respond_to do |format|
      if @line_item.save
        format.js {}
        format.html { redirect_to(products_path, :notice => 'Line item was successfully created.') }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    quantity = @line_item.quantity + params[:quantity].to_i
    respond_to do |format|
      @status = quantity > 0 ? @line_item.update(quantity: quantity) : true
      format.js {}
    end
  end


  def destroy
    @line_item.destroy
    redirect_to shopping_carts_path, notice: 'Line item was successfully destroyed.'
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:cart_id, :product_id)
  end

end
