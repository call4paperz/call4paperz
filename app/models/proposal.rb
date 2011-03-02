class Proposal < ActiveRecord::Base
  attr_accessible :acceptance_points

  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  belongs_to :user
  belongs_to :event

  validates_presence_of :name, :description
  validates_associated :user

  validates_length_of :name, :within => 3..150
  validates_length_of :description, :within => 3..400

  attr_protected :event_id

  def acceptance_points
    votes.positives.count - votes.negatives.count
  end

  def to_json(options=nil)
    super(:include => :comments)
  end

end
