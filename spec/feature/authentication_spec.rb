require 'spec_helper'

feature 'Authentications' do
  scenario 'authenticating with some oauth provider' do
    User.create_from_auth_info 'github', 'github-uid',
                               'name'  => 'Opa Lhes',
                               'email' => 'opalhes@example.org'
    sign_in_via_github('github-uid')

    expect(page).to have_content('Welcome Opa Lhes')
  end

  scenario 'associating authentication with a signed in user' do
    user = User.create_from_auth_info 'github', 'github-uid',
                                      'name'  => 'Opa Lhes',
                                      'email' => 'opalhes@example.org'
    sign_in_via_github('github-uid')

    twitter_uid = 'twitter-123'
    sign_in_via_twitter(twitter_uid)

    expect(user.authentications.map { |a| a.provider }).to include('github', 'twitter')
  end

  context 'twitter' do
    scenario 'forbiddes account creation, since twitter doesn\'t gives us email' do
      twitter_uid = 'twitter-123'
      sign_in_via_twitter(twitter_uid)

      expect(page).to have_content('Or you can use the following services to login:')
      expect(page).to have_content(I18n.t 'auth.cant_create_twitter')
    end

    scenario 'allow authentication if an associated account exists' do
      twitter_uid = 'twitter-123'
      User.create_from_auth_info 'twitter', twitter_uid,
                                 'name'  => 'Opa Lhes',
                                 'email' => 'opalhes@example.org'
      sign_in_via_twitter(twitter_uid)

      expect(page).to have_content('Welcome Opa Lhes')
    end
  end
end
