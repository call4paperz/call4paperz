class Proposal < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  belongs_to :user
  belongs_to :event

  validates_presence_of :name, :description
  validates_associated :user

  attr_protected :event_id
end
