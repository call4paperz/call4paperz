class MergeUser
  def initialize(email)
    @email = email
  end

  def merge
    users = User.where(email: @email)
    raise unless users.size > 0
    return false if users.size == 1

    profiles = users.map { |user| Profile.new user }
    @elected_profile = elect_user_profile(profiles)
    profiles.delete @elected_profile
    @profiles_to_remove = profiles

    User.transaction do
      merge_events
     # merge_auths     auths_for(users)
     # merge_comments  comments_for(users)
     # merge_events    events_for(users)
     # merge_proposals proposals_for(users)
     # merge_votes     votes_for(users)

      # avatar? remove...

      #remove_users users_to_remove
    end
  end

  private

  [ :events ].each do |collection_merge_method|
    define_method "merge_#{collection_merge_method}" do
      merge_collection collection_merge_method
    end
  end

  def merge_collection(collection_name)
    into_collection = @elected_profile.public_send collection_name
    @profiles_to_remove.each do |profile|
      from_collection = profile.public_send collection_name
      into_collection << from_collection
    end
  end

  def count_associations(profile)
    profile.authentications.count +
      profile.comments.count +
      profile.events.count +
      profile.proposals.count +
      profile.votes.count
  end

  # Internal: find the user register with more relations, and return it.
  def elect_user_profile(profiles)
    profiles.sort { |p1, p2|
      count_associations(p1) <=> count_associations(p2)
    }.last
  end
end
