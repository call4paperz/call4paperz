module HelperMethods
  def sign_in_with(user = Factory(:user))
    visit '/users/sign_in'
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Sign up'
  end

  def sign_in
    visit '/users/sign_up'

    fill_in "Email", :with => 'email@example.com'
    fill_in "Password", :with => '123123'
    fill_in "Password confirmation", :with => '123123'
    click_button 'Sign up'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
