require 'rails_helper'

describe Item do
  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a title' do
        category = Category.create(title: "Animals")
        one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
        item = category.items.create(description: "number one", price: 8.00, image: one_url)
        expect(item).to be_invalid
      end

      it 'is invalid without a description' do
        category = Category.create(title: "Animals")
        one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
        item = category.items.create(title: "Funsie Onesie", price: 8.00, image: one_url)
        expect(item).to be_invalid
      end

      it 'is invalid without a price' do
        category = Category.create(title: "Animals")
        one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
        item = category.items.create(title: "Funsie Onesie",  description: "number one", image: one_url)
        expect(item).to be_invalid
      end
      it 'is valid without a image' do
        category = Category.create(title: "Animals")
        item = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00)
        expect(item).to be_valid
      end

      it 'is invalid without a unique title' do
        valid_item = create(:item, title: "Funsie Onesie")
        invalid_item = Item.new(title: "Funsie Onesie")
        expect(invalid_item).to be_invalid
        expect(invalid_item.errors.full_messages).to include("Title has already been taken")
      end
    end
    describe 'valid attributes' do
      it 'condition is active if not specified' do
        category = Category.create(title: "Animals")
        one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
        item_one = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url)
        expect(item_one.condition).to eq('active')
      end
      it 'condition can be set to retired' do
        category = Category.create(title: "Animals")
        one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
        item_one = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url, condition: 'retired')
        expect(item_one.condition).to eq('retired')
      end
    end
  end
  describe "relationships" do
    it "belongs to a category" do
      category = Category.create(title: "Animals")
      one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
      item = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url)
      expect(item).to respond_to(:category)
    end

    it "has many orders" do
      category = Category.create(title: "Animals")
      one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
      item = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00)

      expect(item).to respond_to(:orders)
    end
  end
end
