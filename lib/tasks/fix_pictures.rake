namespace :app do
  desc 'Rebuild all versions of all pictures'
  task :rebuild_picture_versions => :environment do
    Event.find_each do |event|
      event.recreate_versions!
    end
  end
end
