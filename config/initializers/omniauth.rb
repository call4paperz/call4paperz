Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_ACCESS'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_ACCESS'], ENV['FACEBOOK_KEY'], :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}
end
