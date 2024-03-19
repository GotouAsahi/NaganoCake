class Public::CartItemsController < Public::BaseController
  before_action :authenticate_customer!
  def index
    @customer = Customer.find(current_customer.id)
    @cart_items = @customer.cart_items
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    current_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if current_cart_item
      current_cart_item.amount += @cart_item.amount.to_i
      current_cart_item.update(amount: current_cart_item.amount)
      redirect_to cart_items_path
    elsif @cart_item.save
      redirect_to cart_items_path
    else
      # @item = Item.find(@cart_item.item_id)
      @item = Item.find(params[:item_id])
      render template: 'public/items/show'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
