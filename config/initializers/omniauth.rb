Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_ACCESS'], ENV['TWITTER_SECRET']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET'], scope: "user:email"
  provider :facebook, ENV['FACEBOOK_ACCESS'], ENV['FACEBOOK_KEY'],
           client_options: { ssl: { ca_file: '/usr/lib/ssl/certs/ca-certificates.crt' } }
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_SECRET']
end
