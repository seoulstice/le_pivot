require 'rails_helper'

describe Item do
  let(:category) { build(:category, title: "Animals") }

  describe 'validations' do
    describe 'invalid attributes' do
      it 'is invalid without a title' do
        item = build(:item, title: nil)
        expect(item).to be_invalid
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

    it "has many orders" do
      item = build(:item)
      expect(item).to respond_to(:orders)
    end
  end
end
