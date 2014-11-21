# Aggregates the user data. It is an entry point to reach all the data directly
# related to the users. Can be used to add inteligence in between those
# integration points.
#
# TODO:
#   - move all avatar logic to here
#   - move all has vote/event/comment/prop to here
require 'forwardable'

class Profile
  attr_accessor :user
  attr_accessor :authentications, :comments, :events, :proposals, :votes

  extend Forwardable
  def_delegators :@user, :authentications, :comments, :events, :proposals, :votes,
                 :reload, :destroy, :hash

  def initialize(user)
    @user = user
  end

  def ==(profile)
    user == profile.user
  end
  alias_method :eql?, :==

  def unassociated_providers
    Authentication.providers_not_in authentications
  end

  def add_authentication(authentication)
    auth = authentications.
      where(provider: authentication.provider, uid: authentication.uid).first
    unless auth
      authentications << authentication
    end
  end
end
