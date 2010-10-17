class Vote < ActiveRecord::Base
  LIKE = 1
  DISLIKE = -1

  belongs_to :proposal
  belongs_to :user

  validates_presence_of :direction
  validates_associated :user
  validates_associated :proposal

  validates_uniqueness_of :proposal_id, :scope  =>  :user_id

  scope :positives,  where(:direction => 1) 
  scope :negatives,  where(:direction => -1) 

  class << self

    def like! (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => LIKE
    end

    def dislike!  (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => DISLIKE
    end
end

end
