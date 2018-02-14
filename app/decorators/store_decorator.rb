class StoreDecorator < ApplicationDecorator

  has_many :items
  has_many :active_items, class_name: :items

### LINKS ###

  def button_to_update_status_button
    if store.active?
      button_to "Suspend", store_path(store, status: "suspended"), method: :patch
    else
      button_to "Activate", store_path(store, status: "active"), method: :patch
    end
  end

  def link_to_twitter
    if has_twitter?
      link_to "Send A Tweet!", new_store_tweet_path
    else
      link_to "Connect to Twitter", twitter_login_path
    end
  end

end
