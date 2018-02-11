desc 'Create store to represent the original little shop store'
task :create_first_store  => :environment do
  Store.create(name: "The Little Shop of Funsies", status: "active")
end
