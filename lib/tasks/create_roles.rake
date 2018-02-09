desc 'Create basic role objects'
task :create_roles  => :environment do
  Role.create(name: "registered_user")
  Role.create(name: "store_manager")
  Role.create(name: "store_admin")
  Role.create(name: "platform_admin")
end
