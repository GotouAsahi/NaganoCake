class Public::CustomersController < Public::BaseController
  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def unsbscribe
  end

  def withdrow
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name,:last_name,:first_kana,:last_kana,:email,:postal_code,:address,:telephone_number)
  end

end
