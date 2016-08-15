class Vote < ActiveRecord::Base
  LIKE = 1
  DISLIKE = -1

  belongs_to :proposal
  belongs_to :user

  validates_presence_of :direction
  validates_associated :user
  validates_associated :proposal

  validates_uniqueness_of :proposal_id, :scope  =>  :user_id

  scope :positives, -> { where(direction: LIKE) }
  scope :negatives, -> { where(direction: DISLIKE) }

  def self.like(proposal, user)
    vote proposal, user, LIKE
  end

  def self.dislike(proposal, user)
    vote proposal, user, DISLIKE
  end

  def self.vote(proposal, user, direction)
    vote = new
    vote.proposal = proposal
    vote.user = user
    vote.direction = direction
    vote.save
  end

  private_class_method :vote
end
