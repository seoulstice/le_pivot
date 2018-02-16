require_relative '../../db/seeder.rb'


desc 'populate web application with dummy data'
  task :populate_data => :environment do
    Seeder.new.create_all
  end

 
