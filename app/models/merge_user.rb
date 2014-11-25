class MergeUser
  COLLECTIONS = [ :authentications, :comments, :events, :proposals, :votes ]

  def initialize(email)
    @email = email
  end

  def merge
    return false if @email == ''

    users = User.where(email: @email)
    return false if users.size <= 1

    elect_a_profile users
    transfer_avatars
    merge_all_collections
    destroy_extra_profiles

    @elected_profile.user.save!
  end

  private

  COLLECTIONS.each do |collection_merge_method|
    define_method "merge_#{collection_merge_method}" do
      merge_collection collection_merge_method
    end
  end

  def extra_photo
    @profiles_to_remove.map { |profile|
      profile.user.photo? ? profile.user.photo : nil
    }.compact.first
  end

  def transfer_avatars
    user = @elected_profile.user
    return if user.photo?
    user.photo = extra_photo
  end

  def count_associations(profile)
    profile.authentications.count +
      profile.comments.count +
      profile.events.count +
      profile.proposals.count +
      profile.votes.count
  end

  # Internal: find the user register with more relations, and return it.
  def profile_with_more_associations(profiles)
    profiles.sort { |p1, p2|
      count_associations(p1) <=> count_associations(p2)
    }.last
  end

  def elect_a_profile(users)
    profiles = users.map { |user| Profile.new user }
    @elected_profile = profile_with_more_associations profiles
    profiles.delete @elected_profile
    @profiles_to_remove = profiles
  end

  def merge_collection(collection_name)
    into_collection = @elected_profile.public_send collection_name
    @profiles_to_remove.each do |profile|
      from_collection = profile.public_send collection_name
      into_collection << from_collection
    end
  end

  def destroy_extra_profiles
    @profiles_to_remove.each do |profile|
      profile.reload.destroy
    end
  end

  def merge_all_collections
    User.transaction do
      COLLECTIONS.each { |collection| send "merge_#{collection}" }
    end
  end
end
