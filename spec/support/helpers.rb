module HelperMethods
  def sign_in_with(user = FactoryGirl.create(:user))
    visit '/users/sign_in'
    sign_in_from_login_page(user)
  end

  def sign_in_from_login_page(user = FactoryGirl.create(:user))
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    find('input[type=image]').click
  end

  def sign_in
    visit '/users/sign_up'

    fill_in "Email", :with => 'email@example.com'
    fill_in "Password", :with => '123123'
    fill_in "Password confirmation", :with => '123123'
    find('input[type=image]').click
  end
end
