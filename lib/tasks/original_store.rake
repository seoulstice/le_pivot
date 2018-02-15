namespace :original_store do

  task default: [:create, :associate]

  desc 'Create store to represent the original little shop store'
  task create: [:environment] do
    Store.create(name: "The Little Shop of Funsies", status: "active")
    puts 'created original store'
  end

  desc 'After original store is created, associate all current items with that store'
  task associate: :environment do
    original_store_id = Store.first.id
    Item.update_all(store_id: original_store_id)
    puts 'associated all items with original store'
  end

end
