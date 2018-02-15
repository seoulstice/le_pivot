require 'rails_helper'

feature 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do

      item_one, item_two = create_list(:item, 2)
      stub_logged_in_user(create(:platform_admin))
      visit admin_dashboard_path
      click_on "View Items"

      expect(page).to have_content(item_one.title)
      expect(page).to have_content(item_one.price)
      expect(page).to have_content(item_two.title)
      expect(page).to have_content(item_two.price)
      expect(page).to have_content("Edit")

    end
  end
end
