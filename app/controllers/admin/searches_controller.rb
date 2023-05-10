class Admin::SearchesController < Admin::BaseController
  def search
    @items = Item.looks(params[:word])
    render "admin/items/index"
  end
end
