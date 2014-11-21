module OmniauthHelpers
  [ :twitter, :facebook, :github, :google_oauth2 ].each do |provider|
    define_method "sign_in_via_#{provider}" do |uid|
      mock_omniauth_provider(uid, provider)
      visit "/auth/#{provider}"
    end
  end

  def mock_omniauth_provider(uid, provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
      provider: provider,
      uid: uid
    )
  end
end
