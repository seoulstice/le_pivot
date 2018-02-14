module LayoutHelper

  def flash_messages
    flash.map { |name, msg| content_tag :div, raw(msg), class: name }
  end

  def flash_section
    render 'flash' unless flash.empty?
  end

end
