class User < ActiveRecord::Base
  attr_accessor :email_confirmation

  has_many :authentications, :dependent => :destroy
  has_many :comments,        :dependent => :destroy
  has_many :events,          :dependent => :destroy
  has_many :proposals,       :dependent => :destroy
  has_many :votes,           :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, , :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

  validates_presence_of :email, if: :email_required?

  with_options if: :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, within: 6..20, allow_blank: true
  end

  validate :honeypot

  mount_uploader :photo, PictureUploader

  def self.find_or_create_with_authentication(authentication)
    user = User.find_by_email authentication.email
    if user
      Profile.new(user).add_authentication(authentication)
      return user
    end

    user = User.new(
      name: authentication.name,
      remote_photo_url: authentication.image,
      email: authentication.email)
    user.confirmed_at = Time.now
    user.authentications = [ authentication ]
    user.save!
    user
  end

  def picture
    photo_url(:thumb) if photo?
  end

  def has_vote_for?(proposal)
    votes.exists?(:proposal_id => proposal.id)
  end

  def need_profile_completion?
    !email.present?
  end

  def invalid_email_and_unconfirmed?
    email.blank? && unconfirmed_email.present?
  end

  private

  def password_required?
    (authentications.empty? || !password.blank?) &&
      (!persisted? || !password.nil? || !password_confirmation.nil?)
  end

  def email_required?
    authentications.empty?
  end

  def honeypot
    errors.add :email_confirmation, "You must confirm your email" unless email_confirmation.blank?
  end
end
