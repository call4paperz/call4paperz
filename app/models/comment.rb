class Comment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_associated :user, :proposal
end
