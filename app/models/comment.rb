class Comment < ActiveRecord::Base
  belongs_to :proposal, :counter_cache => true
  belongs_to :user

  validates_associated :user, :proposal
  validates_presence_of :body

  # Sad. To be fixed.
  attr_accessible :body, :proposal_id

  def self.most_recent
    order("created_at DESC").limit(4)
  end
end
