require 'rails_helper'

RSpec.describe Cart do
  let(:item_1) { create(:item) }
  let(:item_2) { create(:item) }

  subject { Cart.new({
      "#{item_1.id}" => 2,
      "#{item_2.id}" => 3
    })
  }

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds an item to its contents" do
      item_3 = create(:item)
      subject.add_item(item_1.id)
      subject.add_item(item_3.id)

      expect(subject.contents).to eq({"#{item_1.id}" => 3, "#{item_2.id}" => 3, "#{item_3.id}" => 1})
    end
  end

  describe "#decrease quantity" do
    it "decreases the amount of an item in a cart" do
      subject.decrease_quantity(item_1.id)

      expect(subject.contents).to eq("#{item_1.id}"=>1, "#{item_2.id}"=>3)
    end

    it "can remove an item it it drops to quantity 0" do
      subject.decrease_quantity(item_1.id)
      subject.decrease_quantity(item_1.id)

      expect(subject.contents).to eq("#{item_2.id}"=>3)
    end
  end

  describe "#increase quantity" do
    it "can increase the amount of an item in a cart" do
      subject.increase_quantity(item_1.id)

      expect(subject.contents).to eq("#{item_1.id}" => 3, "#{item_2.id}" => 3)
    end
  end

  describe "#count_of" do
    it "reports how many of a particular item" do
      expect(subject.count_of(item_1.id)).to eq(2)
      expect(subject.count_of(item_2.id)).to eq(3)
    end
  end

  describe "#cart_items" do
    it "returns a hash of item objects and quantity" do
      expect(subject.cart_items[item_1]).to eq(2)
      expect(subject.cart_items[item_2]).to eq(3)
    end
  end

  describe "#delete_item" do
    it "can remove one item from the cart" do
      subject.delete_item(item_1.id)

      expect(subject.contents).to eq("#{item_2.id}" => 3)
    end
  end

  describe "#destroy" do
    it "can remove all items from the cart" do
      subject.destroy

      expect(subject.contents).to eq({})
    end
  end
end
