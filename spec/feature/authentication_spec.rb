require 'spec_helper'

feature 'Authentications' do
  let!(:auth_info) { { 'name'  => 'Opa Lhes',
                       'email' => 'opalhes@example.org',
                       'image' => 'http://call4paperz.com/assets/logo_c4p-ea7e453659d491fc990475d90dc4fd12.png' } }

  scenario 'authenticating with some oauth provider' do
    auth = Authentication.new provider: 'github', uid: 'github-uid'
    auth.auth_info = auth_info
    User.find_or_create_with_authentication auth
    sign_in_via_github('github-uid', {'info' => auth_info})

    expect(page).to have_content('Welcome Opa Lhes')
  end

    scenario 'updates user profile information' do
      auth = Authentication.new provider: 'github', uid: 'github-uid'
      auth.auth_info = auth_info
      user = User.find_or_create_with_authentication auth
      expect(user.name).to eq('Opa Lhes')
      expect(user.email).to eq('opalhes@example.org')
      expect(user.photo.file.filename).to eq('logo_c4p-ea7e453659d491fc990475d90dc4fd12.png')
      sign_in_via_github('github-uid', {'info' => {'name' => 'A new name',
                                                   'email' => 'new@example.org',
                                                   'image' => 'http://call4paperz.com/assets/showcase/1-2d7ffc2e0760e04bf672e37fb4a48aa6.jpg'} })
      expect(user.reload.name).to eq('A new name')
      expect(user.reload.email).to eq('opalhes@example.org')
      expect(user.reload.unconfirmed_email).to eq('new@example.org')
      expect(user.reload.photo.file.filename).to eq('1-2d7ffc2e0760e04bf672e37fb4a48aa6.jpg')
    end

  context 'signed in user' do
    let(:auth) { Authentication.new(provider: 'github', uid: 'github-uid') }
    let(:user) { User.find_or_create_with_authentication auth }

    before do
      auth.auth_info = { 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org' }
      auth.save!
      user.save!
      sign_in_via_github('github-uid', {'info' => auth_info})
    end

    scenario 'associating authentication with a signed in user' do
      twitter_uid = 'twitter-123'
      sign_in_via_twitter(twitter_uid)

      authentication_providers = user.reload.authentications.map { |a| a.provider }
      expect(authentication_providers).to include('github', 'twitter')
    end

    scenario 'using a pre-existent authentication different than the current one' do
      Authentication.new(provider: 'twitter', uid: 'twitter-uid-123')
      sign_in_via_twitter('twitter-uid-123')

      authentication_providers = user.reload.authentications.map { |a| a.provider }
      # do not created repeated authentications for the same provider
      expect(authentication_providers).to eq [ 'github', 'twitter' ]
    end
  end

  context 'twitter authentication provider' do
    scenario 'forbiddes account creation, since twitter doesn\'t gives us email' do
      twitter_uid = 'twitter-123'
      sign_in_via_twitter(twitter_uid)

      expect(page).to have_content('Or you can use the following services to login:')
      expect(page).to have_content(I18n.t 'auth.cant_create_twitter')
    end

    scenario 'allow authentication if an associated account exists' do
      twitter_uid = 'twitter-123'
      auth = Authentication.new provider: 'twitter', uid: twitter_uid
      auth.auth_info = { 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org' }
      User.find_or_create_with_authentication auth
      sign_in_via_twitter(twitter_uid, {'info' => auth_info})

      expect(page).to have_content('Welcome Opa Lhes')
    end
  end

  context 'Existent user using different authentications' do
    let(:auth) { Authentication.new(provider: 'github', uid: 'github-uid') }
    let(:user) { User.find_or_create_with_authentication auth }

    before do
      auth.auth_info = { 'name'  => 'Opa Lhes', 'email' => 'opalhes@example.org' }
    end

    scenario 'sign in with new authentication method' do
      sign_in_via_google_oauth2('google-uid-123', 'info' => { 'email' => user.email })
      # do not create new user
      expect(User.count).to eq 1
      providers = user.reload.authentications.map { |auth| auth.provider }
      # add the new authentication to the user
      expect(providers).to eq ['github',  'google_oauth2']
    end
  end
end
