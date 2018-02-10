require 'rails_helper'

RSpec.describe 'an admin can visit admin dashboard' do
  describe 'and see a link for all items' do
    it 'when clicked that link should be the admin item index with admin functionality' do

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(create(:platform_admin))

      item_one, item_two = create_list(:item, 2)

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
