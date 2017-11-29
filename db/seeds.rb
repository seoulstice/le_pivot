Item.destroy_all
Category.destroy_all
User.destroy_all
Order.destroy_all

User.create(first_name: "Mary", last_name: "Moore", email: "mary@example.com", password: "mary", address: "666 Spooky Ave, Halloween City, NO 66666", role: 1)
user_1 = User.create!(first_name: "Sandy", last_name: "Smith", email: "sandy@example.com", password: "sandy", address: "1111 Hoola Hoop Drive, Big Island, HI 90505", role: 0)
user_2 = User.create(first_name: "Rick", last_name: "Rhodes", email: "rick@example.com", password: "rick", address: "1000 Sunny Dr., Sunshine, CO 10000", role: 0)
user_3 = User.create(first_name: "Daniel", last_name: "Williams", email: "daniel@example.com", password: "daniel", address: "1010 Biking Home, Cool CA 10101", role: 0)

description = "Lorem ipsum dolor sit amet, officiis quaerendum eu nam, voluptua deterruisset vix at. In dico sonet aliquip has, eos prima appellantur ea. Omnesque facilisi cu pro. Ut vix brute etiam repudiare. Esse animal explicari ad eam, vis ex oratio ornatus voluptatibus, movet sadipscing ea qui."

suspense = Category.create(title: "Suspense")
thriller = Category.create(title: "Thriller")
western = Category.create(title: "Western")
crime = Category.create(title: "Crime")
horror = Category.create(title: "Horror")
fantasy = Category.create(title: "Fantasy")
mystery = Category.create(title: "Mystery")
science_fiction = Category.create(title: "Science Fiction")

suspense.items.create(title: Faker::Book.title,
                      description: description,
                      price: 39.99,
                      image: File.new("./app/assets/images/book_cover.png"))


suspense.items.create(title: Faker::Book.title,
                      description: description,
                      price: 59.99,
                     image: File.new("./app/assets/images/book_cover.png"))


thriller.items.create(title: Faker::Book.title,
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


thriller.items.create(title: Faker::Book.title,
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


western.items.create(title: Faker::Book.title,
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/book_cover.png"))


western.items.create(title: Faker::Book.title,
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/book_cover.png"))


crime.items.create(title: Faker::Book.title,
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/book_cover.png"))


horror.items.create(title: Faker::Book.title,
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/book_cover.png"))


fantasy.items.create(title: Faker::Book.title,
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/book_cover.png"))


mystery.items.create(title: Faker::Book.title,
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/book_cover.png"),
                      condition: 1)


science_fiction.items.create(title: Faker::Book.title,
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/book_cover.png"),
                     condition: 1)


science_fiction.items.create(title: Faker::Book.title,
                      description: description,
                      price: 69.99,
                      image: File.new("./app/assets/images/book_cover.png"),
                      condition: 1)


statuses = ["ordered", "paid", "cancelled", "completed"]
users = [user_1.id, user_2.id, user_3.id]

statuses.each do |status|
  users.each do |user|
    Order.create(status: status, user_id: user)
  end
end


Order.all.each do |order|
  order.items << Item.all.sample
end

OrderItem.all.each do |order_item|
  order_item.quantity = rand(1..10)
  order_item.save!
end
