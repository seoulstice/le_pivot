require 'rails_helper'

RSpec.describe Cart do

  subject { Cart.new(
    '1' => 1,
    '3' => 3,
  )}

  describe "#total_count" do
    xit "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(4)
    end
  end

  describe "#increase_quantity" do
    it "adds an item to its contents" do
      subject.increase_quantity(2)
      subject.increase_quantity(3)
      expect(subject.contents).to eq(
        '1' => 1,
        '2' => 1,
        '3' => 4,
      )
    end
  end

  describe "#decrease_quantity" do
    it "decreases the amount of an item in a cart" do
      subject.decrease_quantity(3)
      expect(subject.contents).to eq(
        '1' => 1,
        '3' => 2,
      )
    end

    it "can remove an item it it drops to quantity 0" do
      subject.decrease_quantity(1)
      expect(subject.contents).to eq(
        '3' => 3
      )
    end
  end

  describe "#delete_item" do
    it "can remove one item from the cart" do
      subject.delete_item(3)
      expect(subject.contents).to eq(
        '1' => 1
      )
    end
  end

  describe "#destroy" do
    it "can remove all items from the cart" do
      subject.destroy
      expect(subject.contents).to eq({})
    end
  end
end
