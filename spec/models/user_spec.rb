require "rails_helper"

describe "validations" do
  context "invalid attributes" do

    it "is invalid without a first name" do
      user = build(:user, first_name: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a last name" do
      user = build(:user, last_name: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it "is invalid without an e-mail" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it "is invalid without a unique e-mail" do
      user_1 = create(:user, email: "gob@example.com")
      user_2 = build(:user, email: "gob@example.com")
      expect(user_2).to be_invalid
    end
  end

end
