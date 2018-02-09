require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'support/simple_cov'
require 'feature_helper'
require 'santas_little_helper'
require './db/seeder'

ActiveRecord::Migration.maintain_test_schema!

DatabaseCleaner.strategy = :truncation
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include SantasLittleHelper
  config.include FeatureHelper

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each) do
    allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
  end

  # Required to be false for DatabaseCleaner config below
  config.use_transactional_fixtures = false
  #
  # config.before(:suite) do
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end
  #
  # config.before(:each, :js => true) do
  #   DatabaseCleaner.strategy = :truncation
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end
