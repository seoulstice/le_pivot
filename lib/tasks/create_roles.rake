desc 'Create basic role objects'
task :create_roles  => :environment do
  Seeder.add_roles
end
