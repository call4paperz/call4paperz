worker_processes 3
timeout 30
preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
  Rails.logger.info('Disconnected from ActiveRecord')

  sleep 1
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
  Rails.logger.info('Connected to ActiveRecord')
end
