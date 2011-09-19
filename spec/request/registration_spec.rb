require 'spec_helper'

feature "Registration", %q{
  In order to interact with the site
  As a visitor
  I want to register
} do

  context "Register through sign up form" do
    scenario "While registering, I can't register without an email" do
      visit '/users/sign_up'

      fill_in "Password", :with => '123123'
      fill_in "Password confirmation", :with => '123123'
      find("input[type=image]").click

      page.should have_content "Email can't be blank"
    end

    scenario "While registering, I can't register without a password" do
      visit '/users/sign_up'

      fill_in "Email", :with => 'email@example.com'
      find("input[type=image]").click

      page.should have_content "Password can't be blank"
    end

    scenario "While registering, I can't register without a password confirmation" do
      visit '/users/sign_up'

      fill_in "Email", :with => 'email@example.com'
      fill_in "Password", :with => '123123'
      find("input[type=image]").click

      page.should have_content "Password doesn't match confirmation"
    end

    scenario "While registering, I'm able to register with valid data" do
      visit '/users/sign_up'

      fill_in "Email", :with => 'email@example.com'
      fill_in "Password", :with => '123123'
      fill_in "Password confirmation", :with => '123123'
      find("input[type=image]").click

      page.should have_content "Logout"

      current_path.should eq(root_path)
    end
  end
end
