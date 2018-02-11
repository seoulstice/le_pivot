module Admin::DashboardsHelper

  def twitter_link
    if current_user.oauth_token.present?
      link_to "Send A Tweet!", new_twitter_path, class: "nav-item nav-link"
    else
      link_to "Login to Twitter", twitter_login_path, class: "nav-item nav-link"
    end
  end

  def update_order_status_links(order)
    render locals: { order: order } partial: (
      if order.ordered?
        "_ordered_order_links"
      elsif order.paid?
        "_paid_order_links"
      else
        "_none"
      end
    )
  end

end
