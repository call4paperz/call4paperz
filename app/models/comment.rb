class Comment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_associated :user, :proposal

  def self.most_recent
    order("created_at DESC").limit(4)
  end
end
