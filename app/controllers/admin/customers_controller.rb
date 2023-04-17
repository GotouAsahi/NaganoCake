class Admin::CustomersController < Admin::BaseController
  def index
    @customers=Customer.all
  end

  def show
  end

  def edit
  end
end
