require File.dirname(__FILE__) + "/../spec_helper"
require "steak"
require 'capybara/rails'

Capybara.default_selector = :css

RSpec.configuration.include Capybara, :type => :acceptance
RSpec.configuration.include Delorean, :type => :acceptance
RSpec.configuration.after(:each, :type => :acceptance) do
  page.driver.clear_cookies
  back_to_the_present
end


# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
