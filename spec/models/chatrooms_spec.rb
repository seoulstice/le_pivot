require 'rails_helper'


RSpec.describe Chatroom do
  describe "model tests" do
    it "will return a paratermized slug when #generate slug is called" do
      chatroom = Chatroom.create(topic: "Hot stuff")
      expect(chatroom.generate_slug).to eq("hot-stuff")
    end
  end
end
