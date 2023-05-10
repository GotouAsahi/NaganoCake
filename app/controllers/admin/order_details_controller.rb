class Admin::OrderDetailsController < Admin::BaseController
  def update
    @order_detail=OrderDetail.find(params[:id])
    @order=@order_detail.order
    @order_details=@order.order_details
    if @order_detail.update(order_detail_params)
      @order.update(order_status: 2) if @order_detail.making_status == "in_production"
      @order_detail.order.update(order_status: 3) if @order_details.all?{|order_detail| order_detail.making_status == "production_complete"}
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_params
      params.require(:order_detail).permit(:making_status)
  end
end
