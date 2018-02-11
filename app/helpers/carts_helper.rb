module CartsHelper
  def checkout
    if logged_in?
      button_to "Checkout", orders_path, method: :post
    else
      render 'cart_login'
    end
  end
end
