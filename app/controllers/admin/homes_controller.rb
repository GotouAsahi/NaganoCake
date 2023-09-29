class Admin::HomesController < Admin::BaseController
  def top
    @orders=Order.all.order(id: "DESC")
  end
end
