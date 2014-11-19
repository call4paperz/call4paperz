require 'spec_helper'

feature 'Authentications' do
  scenario 'authenticating with some oauth provider' do
    auth = Authentication.new provider: 'github', uid: 'github-uid'
    auth.create_user 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org'
    sign_in_via_github('github-uid')

    expect(page).to have_content('Welcome Opa Lhes')
  end

  scenario 'associating authentication with a signed in user' do
    auth = Authentication.new(provider: 'github', uid: 'github-uid')
    user = auth.create_user 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org'
    sign_in_via_github('github-uid')

    twitter_uid = 'twitter-123'
    sign_in_via_twitter(twitter_uid)

    authentication_providers = user.reload.authentications.map { |a| a.provider }
    expect(authentication_providers).to include('github', 'twitter')
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
      auth = Authentication.new provider: 'twitter', uid: twitter_uid
      auth.create_user 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org'
      sign_in_via_twitter(twitter_uid)

      expect(page).to have_content('Welcome Opa Lhes')
    end
  end
end
