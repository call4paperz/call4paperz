module HelperMethods

  def sign_in_with(user = FactoryGirl.create(:user), password = nil)
    visit '/users/sign_in'
    sign_in_from_login_page(user, password)
  end

  def sign_in_from_login_page(user = FactoryGirl.create(:user), password = nil)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password || user.password
    find('input[type=image]').click
  end

  def sign_in
    sign_in_with create_confirmed_user
  end

  def fixture_file(fixture)
    Rails.root.join('spec', 'support', 'fixtures', fixture)
  end

  def create_confirmed_user
    user = User.where(email: 'confirmed_user@example.com').first
    unless user
      user = FactoryGirl.create(:user, email: 'confirmed_user@example.com')
      user.confirm
    end
    user
  end

  module Controllers
    include Devise::TestHelpers

    def sign_in_user_without_email(request, user = nil)
      user ||= FactoryGirl.create :user
      user.update_attribute :email, ''
      User.connection.execute "update users set email = '' where id ='#{user.id}'"
      sign_in user
      user
    end
  end
end
