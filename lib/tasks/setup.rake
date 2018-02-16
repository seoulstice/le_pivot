task :setup do
    Rake::Task["load"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["original_store:default"].invoke
    Rake::Task["create_roles"].invoke
    Rake::Task["carrierwave:default"].invoke
    Rake::Task["populate_data"].invoke
end
