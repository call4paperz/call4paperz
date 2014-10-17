module OmniauthHelpers
  def sign_in_via_twitter(uid)
    mock_omniauth_provider(uid, 'twitter')
    visit '/auth/twitter'
  end

  def sign_in_via_facebook(uid)
    mock_omniauth_provider(uid, 'facebook')
    visit '/auth/facebook'
  end

  def sign_in_via_github(uid)
    mock_omniauth_provider(uid, 'github')
    visit '/auth/github'
  end

  def mock_omniauth_provider(uid, provider)
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new({
      provider: provider,
      uid: uid
    })
  end
end
