class Proposal < ActiveRecord::Base
  JSON_ATTRIBUTES = [:id, :name, :created_at, :description, :occurs_at].freeze

  GRACE_PERIOD = 30.minutes

  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  belongs_to :user
  belongs_to :event, counter_cache: true

  validates_presence_of :name, :description
  validates_associated :user

  validates_length_of :name, :within => 3..150
  validates_length_of :description, :within => 3..400

  def self.with_preloads
    select('SUM(v.direction) as acceptance_points, proposals.*').
      joins('LEFT JOIN votes v ON v.proposal_id = proposals.id').
      group('proposals.id').
      order('acceptance_points DESC')
  end

  def acceptance_points
    attributes['acceptance_points'].try(:to_i) || votes.sum('direction')
  end

  def as_json(options=nil)
    super(:include => [:comments, :user], :only => JSON_ATTRIBUTES, :methods => [:comments_count])
  end

  def votes_count
    votes.count
  end

  def comments_count
    comments.count
  end

  def positive_points
    votes.positives.count
  end

  def negative_points
    votes.negatives.count
  end

  def grace_period_left
    grace = (created_at - GRACE_PERIOD.ago).to_i
    grace > 0 ? grace : 0
  end

  def has_grace_period_left?
    grace_period_left > 0
  end
end
