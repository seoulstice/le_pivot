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
    return render 'cart_login' unless viewer.registered?
    link_to "Checkout", new_charge_path
  end

  def account_buttons
    return render 'nav_login' unless viewer.registered?
    render 'nav_account'
  end

end
