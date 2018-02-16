require 'rails_helper'

feature 'Item Management' do

  let(:manager){ create(:store_manager) }
  let(:store){ manager.stores.first }
  background do
    stub_logged_in_user(manager)
    visit(store_path(store))
    create(:category)
  end

  describe 'creation' do
    scenario 'Manager can create an item with an image' do
      VCR.use_cassette("admin_create_item_cassette") do
      click_on 'Add Item'
      fill_in 'item[title]', with: 'Onesie'
      fill_in 'item[description]', with: 'This Onesie is awesome!'
      fill_in 'item[price]', with: '59.99'
      page.attach_file('item[image]', testing_image)
      click_on 'Create Item'

      expect(current_path).to eq(store_path(store))
      expect(page).to have_content('Onesie')
      expect(page).to have_content('59.99')
    end

    scenario 'Manager can create an item with no image' do
      click_on 'Add Item'
      fill_in 'item[title]', with: 'Onesie'
      fill_in 'item[description]', with: 'This Onesie is awesome!'
      fill_in 'item[price]', with: '59.99'
      click_on 'Create Item'

      expect(current_path).to eq(store_path(store))
      expect(page).to have_content('Onesie')
      expect(page).to have_content('59.99')
    end
  end

  describe 'updating' do
    scenario 'Manager can edit an item' do
      create(:item, store: store)
      visit store_path(store)
      click_on 'Edit'
      fill_in 'item[title]', with: 'White Cat Twosie'
      fill_in 'item[price]', with: '39.99'
      click_on 'Update'

      expect(current_path).to eq(store_path(store))
      expect(page).to have_content('White Cat Twosie')
      expect(page).to have_content('39.99')
    end
  end

end
