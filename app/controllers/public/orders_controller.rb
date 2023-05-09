class Public::OrdersController < ApplicationController
  before_action :cart_check,only: [:new,:create]
  def new
    @order=Order.new
  end

  def confirmation
    @cart_items=current_customer.cart_items
    @total=0
    @shipping_cost=800
    @order=Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def completion
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost=800
    @cart_items=current_customer.cart_items
    if @order.save
      @cart_items.each do |cart_item|
      OrderDetail.create!(
      order_id: @order.id, item_id: cart_item.item_id, price: cart_item.item.add_tax_price, amount: cart_item.amount)
      end
      current_customer.cart_items.destroy_all
      redirect_to completion_path
    else
      @total=0
      @shipping_cost=800
      render template: "public/orders/new"
    end
  end
  def index
  end

  def show
  end

  private

  def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method,:total_payment)
  end

  def cart_check
    cart_items=current_customer.cart_items.all
    if cart_items.empty?
      flash[:cart_nill] = "カートが空です"
      redirect_to cart_items_path
    end
  end
end
