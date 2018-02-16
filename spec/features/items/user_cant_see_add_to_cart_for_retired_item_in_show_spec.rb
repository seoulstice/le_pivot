require 'rails_helper'

feature 'Retired Item Show Page' do
		scenario 'a user cannot see add to cart for a retired item' do
			category = Category.create(title: "Animals")
			item_one = category.items.create!(title: "Funsie Onesie", description: "number one", price: 8.00,
			image: one_url, condition: 'retired' )

			visit item_path(item_one)

			expect(page).not_to have_content("Add to cart")
		end
	end
end
