class Proposal < ActiveRecord::Base
  has_many :votes
  has_many :comments

  belongs_to :user
  belongs_to :event

  validates_presence_of :name, :description
  validates_associated :user
end
