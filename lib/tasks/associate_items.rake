desc 'After original store is created, associate all current items with that store'
task :associate_items => :environment do
  original_store_id = Store.first.id
  Item.all.each do |item|
    item.store_id = original_store_id
    item.save
  end
end

puts "task complete"
