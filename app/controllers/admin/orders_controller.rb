class Admin::OrdersController < Admin::BaseController
  def index
    @orders=Order.all.order(id: "DESC")
  end

  def show
    @order=Order.find(params[:id])
    @order_details=@order.order_details
    @total=0
  end

  def update
    @order=Order.find(params[:id])
    if @order.update(order_params)
      @order.order_details.update_all(making_status: 1) if @order.order_status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
      params.require(:order).permit(:order_status)
  end
end
