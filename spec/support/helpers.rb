module HelperMethods
  def sign_in_with(user = FactoryGirl.create(:user))
    visit '/users/sign_in'
    sign_in_from_login_page(user)
  end

  def sign_in_from_login_page(user = FactoryGirl.create(:user))
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    find('input[type=image]').click
  end

  def sign_in
    visit '/users/sign_up'

    within 'form#new_user' do
      fill_in 'user_email', :with => 'email@example.com'
      fill_in 'user_password', :with => '123123'
      fill_in 'user_password_confirmation', :with => '123123'
      find('input[type=image]').click
    end
  end
end
