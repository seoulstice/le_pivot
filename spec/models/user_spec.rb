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

  context "it can have one of two roles" do
    it "has a role" do
      user = build(:user)
      expect(user.role).to eq("default")
    end

    it "can be an admin" do
      user = build(:user, role: "admin")
      expect(user.role).to eq("admin")
    end
  end

  context "instance methods" do
    it "can return user's full name" do
      user = User.new(first_name: "McTest",last_name: "McTest", password: "testing", email: "tester@testmail")
      expect(user.full_name).to eq("McTest McTest")
    end

    it "can return the date a user joined" do
      user = User.create(first_name: "McTest",last_name: "McTest", password: "testing", email: "tester@testmail", created_at: "2017-09-13 01:13:04 -0600")
      expect(user.date_joined).to eq("Sep. 13, 2017")
    end
  end
end
