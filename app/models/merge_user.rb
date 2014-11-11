class MergeUser
  def initialize(email)
    @email = email
  end

  def merge
    users = User.where(email: @email)
    raise unless users.size > 0
    return false if users.size == 1

    elected_user = elect_user(users)
    users_to_remove = users - [elected_user]

    User.transaction do
      merge_auths     auths_for(users)
      merge_comments  comments_for(users)
      merge_events    events_for(users)
      merge_proposals proposals_for(users)
      merge_votes     votes_for(users)

      # avatar? remove...

      remove_users users_to_remove
    end
  end
end
