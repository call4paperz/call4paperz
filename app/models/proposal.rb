class Proposal < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  belongs_to :user
  belongs_to :event

  validates_presence_of :name, :description
  validates_associated :user

  validates_length_of :name, :within => 3..150
  validates_length_of :description, :within => 3..400

  attr_protected :event_id


  def acceptance_percentage
    positive_count = votes.positives.count
    negative_count = votes.negatives.count
    total_count = votes.count.to_f

    if total_count == 0.0 or positive_count == negative_count
      50.0
    elsif positive_count > negative_count
      (positive_count / total_count) * 100
    else
      -(negative_count / total_count) * 100
    end
  end

end
