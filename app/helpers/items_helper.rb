module ItemsHelper
  def add_to_cart_button(item)
    if item.active?
      button_to "Add to cart", cart_path(item_id: item.id), class: badge(:primary)
    else
      content_tag :div, 'Retired', class: badge(:secondary)
    end
  end
end
