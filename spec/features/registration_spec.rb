require 'spec_helper'

feature "Registration", %q{
  In order to interact with the site
  As a visitor
  I want to register
} do

  context "Register through sign up form" do
    scenario "While registering, I can't register without an email" do
      visit '/users/sign_up'

      fill_in "user_password", :with => '123123'
      fill_in "user_password_confirmation", :with => '123123'
      find("input[type=image]").click

      expect(page).to have_content "Email can't be blank"
    end

    scenario "While registering, I can't register without a password" do
      visit '/users/sign_up'

      fill_in "user_email", :with => 'email@example.com'
      find("input[type=image]").click

      expect(page).to have_content "Password can't be blank"
    end

    scenario "While registering, I can't register without a password confirmation" do
      visit '/users/sign_up'

      fill_in "user_email", :with => 'email@example.com'
      fill_in "user_password", :with => '123123'
      find("input[type=image]").click

      expect(page).to have_content "Password confirmation doesn't match"
    end

    scenario "While registering, I'm able to register with valid data" do
      visit '/users/sign_up'

      fill_in "user_email", with: 'email@example.com'
      fill_in "user_password", with: '123123'
      fill_in "user_password_confirmation", with: '123123'
      find("input[type=image]").click

      expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'

      user = User.where(email: 'email@example.com').first
      user.confirm
      sign_in_with user, '123123'
      expect(page).to have_content 'Logout'

      expect(current_path).to eq(root_path)
    end
  end
end
