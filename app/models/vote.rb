class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_presence_of :direction
  validates_associated :user
  validates_associated :proposal
  
  validates_uniqueness_of :proposal_id, :scope  =>  :user_id
  
  class << self
  
    def like! (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => 1
    end
  
    def dislike!  (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => -1      
    end
end
  
end
