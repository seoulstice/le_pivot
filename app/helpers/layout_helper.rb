module LayoutHelper
  
  def flash_messages
    flash.map { |name, msg| content_tag :div, raw(msg), class: name }
  end

  def flash_section
    render 'flash' unless flash.empty?
  end

  def account_parital
    if logged_in? 'nav_account' else 'nav_login' end
  end

end
