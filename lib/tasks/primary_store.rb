desc 'Create store to represent the original little shop store'
task :create_first_store do
  Store.create(name: "The Little Shop")
end
