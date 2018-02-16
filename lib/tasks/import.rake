task :load => :environment do
  load_cmd = "psql -d the_pivot_development -f #{Rails.root.join("backup.sql")}"
  puts "will load Data dump into local PG database with command:"
  puts load_cmd
  system(load_cmd)
end
