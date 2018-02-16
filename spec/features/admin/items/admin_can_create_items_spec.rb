require 'rails_helper'

feature 'Admin Item Management' do
  background { stub_logged_in_user(create(:platform_admin)) }

  describe 'creation' do
    background do
      create(:category)
      visit admin_items_path
    end

    it 'Admin can create an item with an image' do
      VCR.use_cassette("admin_create_item_cassette") do
        click_on 'Create New Item'
        fill_in 'item[title]', with: 'Onesie'
        fill_in 'item[description]', with: 'This Onesie is awesome!'
        fill_in 'item[price]', with: '59.99'
        page.attach_file('item[image]', testing_image)
        click_on 'Create Item'

        expect(current_path).to eq(admin_items_path)
        expect(page).to have_content('Onesie')
        expect(page).to have_content('59.99')
      end
    end

    it 'Admin can create an item with no image' do
      click_on 'Create New Item'
      fill_in 'item[title]', with: 'Onesie'
      fill_in 'item[description]', with: 'This Onesie is awesome!'
      fill_in 'item[price]', with: '59.99'
      click_on 'Create Item'

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content('Onesie')
      expect(page).to have_content('59.99')
    end
  end

  describe 'updating' do
    it 'Admin can edit an item' do
      VCR.use_cassette("admin_updating_item_cassette") do
        create(:item)
        visit admin_items_path
        click_on 'Edit'
        fill_in 'item[title]', with: 'White Cat Twosie'
        fill_in 'item[description]', with: 'two is better'
        fill_in 'item[price]', with: '39.99'
        page.attach_file('item[image]', testing_image)
        click_on 'Update'

        expect(page).to have_content('White Cat Twosie')
        expect(page).to have_content('39.99')
      end
    end
  end

end
