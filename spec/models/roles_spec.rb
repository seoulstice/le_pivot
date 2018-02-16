require 'rails_helper'

RSpec.describe Role do
  context "validations" do
    it "will not save without a name " do
      role = Role.new
      expect(role).to_not be_valid
    end

    it "will save with a name" do
      role  = Role.new(name: "HAHAHA")
      expect(role).to be_valid
    end
  end

  context "class methods" do
    it "#to_sym takes name attribute and symbolizes" do
      role = Role.new(name: "TYJ")
      expect(role.to_sym).to eq(:TYJ)
    end
  end

end
