require 'rails_helper'

describe Item do

  it "::top_three" do
    def item_with_two_order_items(sold_per_order_item)
      create(:item) do |item|
        create_list(:order_item, 2, item: item, quantity: sold_per_order_item)
      end
    end

    six   = item_with_two_order_items(3)
    four  = item_with_two_order_items(2)
    two   = item_with_two_order_items(1)
    eight = item_with_two_order_items(4)

    expect(Item.top_three.to_a).to eq([eight, six, four])
  end

  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a title' do
        item = build(:item, title: nil)
        expect(item).to be_invalid
      end

      it 'is invalid if a title isnt unique' do
        item = create(:item, title: "boo")
        item_2 = build(:item, title: "boo")
        expect(item_2).to be_invalid
      end


      it 'is invalid without a description' do
        item = build(:item, description: nil)
        expect(item).to be_invalid
      end

      it 'is invalid without a price' do
        item = build(:item, price: nil)
        expect(item).to be_invalid
      end

      it 'is valid without a image' do
        item = build(:item, image: nil)
        expect(item).to be_valid
      end

      it 'is invalid without a unique title' do
        persisted_valid_item = create(:item, title: "Funsie Onesie")
        invalid_item = build(:item, title: "Funsie Onesie")
        expect(invalid_item).to be_invalid
        expect(invalid_item.errors.full_messages).to include("Title has already been taken")
      end
    end

    describe 'valid attributes' do
      it 'condition is active if not specified' do
        item = build(:item)
        expect(item.condition).to eq('active')
      end

      it 'condition can be set to retired' do
        item = build(:item, condition: "retired")
        expect(item.condition).to eq('retired')
      end
    end
  end

  describe "relationships" do
    it "belongs to a category" do
      item = build(:item)
      expect(item).to respond_to(:category)
    end

    it "belongs to a store" do
      item = build(:item)
      expect(item).to respond_to(:store)
    end

    it "has many orders" do
      item = build(:item)
      expect(item).to respond_to(:orders)
    end

    it "has many order_items" do
      item = build(:item)
      expect(item).to respond_to(:order_items)
    end

  end
end
