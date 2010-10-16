require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

RSpec.configuration.include Capybara, :type => :acceptance
RSpec.configuration.after(:each, :type => :acceptance) do
  page.driver.clear_cookies
end


# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
