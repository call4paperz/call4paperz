require 'simplecov'

SimpleCov.start 'rails' do
  add_group "Serializers", "app/serializers"
end

ENV['RAILS_ENV'] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment"
require 'rspec/rails'
require 'database_cleaner'

ActiveRecord::Migration.check_pending!
ActiveRecord::Migration.maintain_test_schema!

DatabaseCleaner.strategy = :truncation

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.include HelperMethods,       :type => :feature
  config.include OmniauthHelpers,     :type => :feature
  config.include Devise::Test::ControllerHelpers, :type => :controller

  config.infer_spec_type_from_file_location!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # this server preparation can be removed as soon as we remove the
  # twitter_avatar form the project
  class RSpecState
    def self.my_server_pid=(pid)
      @pid = pid
    end

    def self.my_server_pid
      @pid
    end
  end
end
