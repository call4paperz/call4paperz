class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :proposals, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def has_vote_for?(proposal)
    votes.exists?(:proposal_id => proposal.id)
  end
end
