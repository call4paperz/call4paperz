namespace :app do
  desc "Update counter caches for proposals"
  task :update_counter_cache => :environment do
    Proposal.pluck('id').each do |id|
      Proposal.reset_counters(id, :comments)
    end
  end
end
