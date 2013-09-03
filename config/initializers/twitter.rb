Twitter.configure do |config|
  config.consumer_key     = ENV['TWITTER_ACCESS']
  config.consumer_secret  = ENV['TWITTER_SECRET']
end