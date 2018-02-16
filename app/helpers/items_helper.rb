module ItemsHelper
  def add_to_cart_button(item)
    if item.active?
      link_to "Add to cart", cart_path(item_id: item.id), method: "post", class: badge(:primary)
    else
      content_tag :div, 'Retired', class: badge(:secondary)
    end
  end
end
