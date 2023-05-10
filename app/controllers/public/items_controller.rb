class Public::ItemsController < Public::BaseController
  before_action :authenticate_customer!, except: [:index,:show]
  def index
    if params[:genre_id].nil?
      @items = Item.where(is_active: true)
    else
      @items = Item.where(is_active: true).where(genre_id: params[:genre_id])
    end

    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end
end
