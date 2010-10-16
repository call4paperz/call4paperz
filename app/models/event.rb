class Event < ActiveRecord::Base
  has_many :proposals
  belongs_to :user

  validates_presence_of :name, :description, :occurs_at
  validates_associated :user

end
