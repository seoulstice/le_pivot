module RolesHelper

  ### ADMIN ###
    def platform_admin_to_update_store_status(store)
      return unless viewer.platform_admin?
      store.button_to_update_status
    end

    def platform_admin_dashboard_tabs
      return unless viewer.platform_admin?
      render 'dashboards/admin/tabs'
    end

  ### MANAGEMENT ###
    def management_to_new_item(store)
      return unless current_user.stores.include?(store)
      link_to("Add Item", new_store_item_path(store))
    end

    def management_to_edit_item(store, item)
      return unless current_user.stores.include?(store)
      link_to("Edit", edit_store_item_path(store, item))
    end

  ### REGISTERED ###
    def registered_to_new_charge
      return render 'cart_login' unless viewer.registered?
      submit_tag "Calculate Shipping Cost"
    end

    def account_buttons
      return render 'nav_login' unless viewer.registered?
      render 'nav_account'
    end

end
