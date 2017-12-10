Item.destroy_all
Category.destroy_all
User.destroy_all
Order.destroy_all

User.create(first_name: "Mary", last_name: "Moore", email: "mary@example.com", password: "password", address: "666 Spooky Ave, Halloween City, NO 66666", role: 1)
user_1 = User.create!(first_name: "Sandy", last_name: "Smith", email: "sandy@example.com", password: "password", address: "1111 Hoola Hoop Drive, Big Island, HI 90505", role: 0)
user_2 = User.create(first_name: "Rick", last_name: "Rhodes", email: "rick@example.com", password: "password", address: "1000 Sunny Dr., Sunshine, CO 10000", role: 0)
user_3 = User.create(first_name: "Daniel", last_name: "Williams", email: "daniel@example.com", password: "password", address: "1010 Biking Home, Cool CA 10101", role: 0)

50.times do |i|
  puts "created user #{i}"
  name = Faker::TwinPeaks.character.split

  User.create(first_name: name.first,
              last_name: name.last,
              email: Faker::Internet.email,
              password: "password",
              address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr} #{Faker::Address.zip}",
              role: "default")
end

suspense = Category.create(title: "Suspense")
thriller = Category.create(title: "Thriller")
western = Category.create(title: "Western")
crime = Category.create(title: "Crime")
horror = Category.create(title: "Horror")
fantasy = Category.create(title: "Fantasy")
mystery = Category.create(title: "Mystery")
science_fiction = Category.create(title: "Science Fiction")

categories = Category.all

suspense.items.create(title: Faker::Book.title,
                      description: Faker::Hipster.sentence,
                      price: 39.99,
                      image: File.new("./app/assets/images/book_cover.png"))


suspense.items.create(title: Faker::Book.title,
                      description: Faker::Hipster.sentence,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


thriller.items.create(title: Faker::Book.title,
                      description: Faker::Hipster.sentence,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


thriller.items.create(title: Faker::Book.title,
                      description: Faker::Hipster.sentence,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


western_item = western.items.create(title: Faker::Book.title,
                                    description: Faker::Hipster.sentence,
                                    price: 59.99,
                                    image: File.new("./app/assets/images/book_cover.png"))


western.items.create(title: Faker::Book.title,
                     description: Faker::Hipster.sentence,
                     price: 49.99,
                     image: File.new("./app/assets/images/book_cover.png"))


crime_item = crime.items.create(title: Faker::Book.title,
                                description: Faker::Hipster.sentence,
                                price: 49.99,
                                image: File.new("./app/assets/images/book_cover.png"))


horror.items.create(title: Faker::Book.title,
                    description: Faker::Hipster.sentence,
                    price: 49.99,
                    image: File.new("./app/assets/images/book_cover.png"))


fantasy.items.create(title: Faker::Book.title,
                     description: Faker::Hipster.sentence,
                     price: 29.99,
                     image: File.new("./app/assets/images/book_cover.png"))


mystery.items.create(title: Faker::Book.title,
                     description: Faker::Hipster.sentence,
                     price: 29.99,
                     image: File.new("./app/assets/images/book_cover.png"),
                     condition: 1)


science_fiction.items.create(title: Faker::Book.title,
                             description: Faker::Hipster.sentence,
                             price: 29.99,
                             image: File.new("./app/assets/images/book_cover.png"),
                             condition: 1)


science_fiction.items.create(title: Faker::Book.title,
                             description: Faker::Hipster.sentence,
                             price: 69.99,
                             image: File.new("./app/assets/images/book_cover.png"),
                             condition: 1)

1000.times do |i|
  puts "creating item #{i}"
  Item.create!(title: Faker::Book.title + " #{i}",
               description: Faker::Hipster.sentence,
               price: rand(700..7000) / 100.0,
               category: categories.sample,
               image: File.new("./app/assets/images/book_cover.png",
               condition: 1))
end

statuses = ["ordered", "paid", "cancelled", "completed"]
user_ids = User.pluck(:id)
items    = Item.all

user_ids.each do |user_id|
  Order.create(status: statuses.sample, user_id: user_id) do |order|
    order.order_items.new(item: items.sample, quantity: rand(1..5))
  end
end

user_3.orders.create(status: "paid") do |order|
  order.order_items.new(item: western_item, quantity: 2)
  order.order_items.new(item: crime_item, quantity: 7)
end

