module StoresHelper
  def admin_update_store_status_button(store)
    if !current_user.platform_admin?
      ''
    elsif store.active?
      button_to "Suspend", store_path(store, status: "suspended"), method: :patch
    else
      button_to "Activate", store_path(store, status: "active"), method: :patch
    end
  end
end
