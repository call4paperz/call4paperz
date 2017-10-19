require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
    }

    config.fog_use_ssl_for_aws = false
    config.fog_directory       = 'cdn.call4paperz.com'
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
end
