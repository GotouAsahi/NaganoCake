class Public::CartItemsController < ApplicationController
  def index
    @customer=Customer.find(current_customer.id)
    @cart_items=@customer.cart_items.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(@cart_item.item_id)
      render template: "public/items/show"
    end
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end