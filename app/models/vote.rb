class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_presence_of :direction
  validates_associated :user
  validates_associated :proposal
  
  class << self
  
    def like! (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => 1
    end
  
    def dislike!  (proposal, user)
      Vote.create :proposal  => proposal, :user  => user, :direction  => -1      
    end
end
  
end
