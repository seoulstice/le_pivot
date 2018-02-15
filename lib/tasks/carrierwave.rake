namespace :carrierwave do
  task default: [:migrate_item_images]

  task :migrate_item_images do
    Item.update_all(image:
      "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png"
    )
    puts "item images updated"
  end

  task :migrate_order_images do
    Order.update_all(image:
      "http://res.cloudinary.com/tyjoo27/image/upload/v1518213324/cp82cjhrlplyxbet4gko.png"
    )
    puts "order images updated"
  end
end
