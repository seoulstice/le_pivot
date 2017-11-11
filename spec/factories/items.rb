FactoryGirl.define do
  factory :item do
    title "Doves"
    description "Dead dove. Do not eat."
    price 10.00
    image File.open("./spec/support/images/test_image.jpg")
    category
  end
end


