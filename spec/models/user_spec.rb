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

  context "valid attributes" do
    it "is valid only with valid attributes" do
      user = User.new(first_name: "tj", last_name: "joo", email: "a@a.com", password: '123')
      expect(user).to be_valid
    end
  end

  context "relationships" do
    scenario "a user has a relatiosnhip with orders" do
      user = build(:user)
      expect(user).to respond_to(:orders)
    end

    scenario "a user has a relatiosnhip with user_roles" do
      user = build(:user)
      expect(user).to respond_to(:user_roles)
    end

    scenario "a user has a relatiosnhip with roles" do
      user = build(:user)
      expect(user).to respond_to(:roles)
    end

    scenario "a user has a relatiosnhip with stores" do
      user = build(:user)
      expect(user).to respond_to(:stores)
    end

    scenario "a user has a relatiosnhip with api_key" do
      user = build(:user)
      expect(user).to respond_to(:api_key)
    end

    scenario "a user has a relatiosnhip with twitter_account" do
      user = build(:user)
      expect(user).to respond_to(:twitter_account)
    end

    scenario "a user has a relatiosnhip with messages" do
      user = build(:user)
      expect(user).to respond_to(:messages)
    end

    scenario "a user has a relatiosnhip with chatrooms" do
      user = build(:user)
      expect(user).to respond_to(:chatrooms)
    end
  end
end
