module RolesHelper

  def admin_update_store_status_button(store)
    return unless viewer.platform_admin?
    store.button_to_update_status
  end

  def admin_update_order_status_buttons(order)
    return unless viewer.platform_admin?
    render 'orders/update_status_buttons', order: order
  end

  def registered_checkout
    if viewer.registered?
      button_to "Checkout", orders_path
    else
      render 'cart_login'
    end
  end

  def account_buttons
    render(
      if logged_in?
        'nav_account' else 'nav_login'
      end
    )
  end

end
