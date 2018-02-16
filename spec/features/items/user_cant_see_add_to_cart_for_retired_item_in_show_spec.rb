require 'rails_helper'

feature 'Retired Item Show Page' do
	scenario 'a user cannot see add to cart for a retired item' do
		item = create(:item, condition: :retired)
		visit item_path(item)
		expect(page).not_to have_content("Add to cart")
	end
end
