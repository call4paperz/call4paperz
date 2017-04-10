if Rails.env.production?
  Airbrake.configure do |config|
    config.host = ENV['AIRBRAKE_URL']
    config.project_id = 1
    config.project_key = ENV['AIRBRAKE_TOKEN']
  end
end

