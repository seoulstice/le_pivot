class ItemDecorator < ApplicationDecorator

  formats_currency :price

### LINKS ###

  def link_to_show
    link_to(title, item_path(id))
  end

  def link_to_edit
    link_to(title, item_path(id))
  end

end
