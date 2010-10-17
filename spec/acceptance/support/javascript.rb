RSpec.configure do |config|
  config.before(:each) do 
    Capybara.current_driver = :culerity if running_example.metadata[:js]
  end
  config.after(:each) do
    Capybara.use_default_driver if running_example.metadata[:js]
  end
end
