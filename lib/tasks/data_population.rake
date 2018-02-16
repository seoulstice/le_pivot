require_relative '../../db/seeder.rb'


desc 'populate web application with dummy data' do
  task :populate_data => :environment do
    Seeder.new.create_all
  end
end
