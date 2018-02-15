desc "associate book to current items and order"
    task associate_image_with_item: :environment do
      Item.find_each do |item|
        item.update(image: "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png" )
      end

      Order.find_each do |order|
        order.update(image: "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png")
      end
      puts "image swapped!"
    end
