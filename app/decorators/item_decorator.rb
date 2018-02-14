class ItemDecorator < ApplicationDecorator

  formats_currency :price

### LINKS ###

  def link_to_show
    link_to(title, item_path(id))
  end

  def link_to_edit
    link_to(title, item_path(id))
  end

  # def button_to_add_to_cart
    # if active?
  #     button_to "Add to cart", cart_path(item_id: id), class: badge(:primary)
    # else
    #   content_tag :div, 'Retired', class: badge(:secondary)
    # end
  # end

end
