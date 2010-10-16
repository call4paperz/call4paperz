module HelperMethods
  # Put helper methods you need to be available in all tests here.
  def sign_in
    visit '/users/sign_up'

    fill_in "Email", :with => 'email@example.com'
    fill_in "Password", :with => '123123'
    fill_in "Password confirmation", :with => '123123'
    click_button 'Sign up'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
