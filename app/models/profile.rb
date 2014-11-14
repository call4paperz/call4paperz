# Aggregates the user data. It is an entry point to reach all the data directly
# related to the users. Can be used to add inteligence in between those
# integration points.
#
# TODO:
#   - move all avatar logic to here
#   - move all has vote/event/comment/prop to here
class Profile
  attr_accessor :user
  attr_accessor :authentications, :comments, :events, :proposals, :votes

  def_delegators :@user, :authentications, :comments, :events, :proposals, :votes

  def initialize(user)
    @user = user
  end
end
