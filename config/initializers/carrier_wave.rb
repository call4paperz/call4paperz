CarrierWave.configure do |config|
  config.s3_access_key_id = ENV['S3_ACCESS_KEY']
  config.s3_secret_access_key = ENV['S3_SECRET_KEY']
  config.s3_bucket = 'cdn.call4paperz.com'
end
