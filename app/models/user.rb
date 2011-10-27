class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

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
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :picture

  validates_presence_of   :email, :if => :email_required?

  with_options :if => :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, :within => 6..20, :allow_blank => true
  end

  def has_vote_for?(proposal)
    votes.exists?(:proposal_id => proposal.id)
  end

  def picture
    attributes['picture'] || '/images/no_avatar.png'
  end

  private

  def password_required?
    (authentications.empty? || !password.blank?) && (!persisted? || !password.nil? || !password_confirmation.nil?)
  end

  def email_required?
    authentications.empty?
  end


end
