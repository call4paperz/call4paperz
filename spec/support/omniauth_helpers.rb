module OmniauthHelpers
  [ :twitter, :facebook, :github, :google_oauth2 ].each do |provider|
    define_method "sign_in_via_#{provider}" do |uid, options = {}|
      mock_omniauth_provider(uid, provider, options)
      visit "/auth/#{provider}"
    end
  end

  def mock_omniauth_provider(uid, provider, options = {})
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
      {
        provider: provider,
        uid: uid
      }.merge(options)
    )
  end
end
