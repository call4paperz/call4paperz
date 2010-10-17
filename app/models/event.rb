class Event < ActiveRecord::Base
  has_many :proposals, :dependent => :destroy
  has_many :comments, :through  => :proposals
  has_many :votes, :through  => :proposals
  belongs_to :user

  validates_date :occurs_at, :on => :create, :on_or_after => :today

  validates_presence_of :name, :description, :occurs_at
  validates_associated :user

  before_validation :twitter_has_valid_format

  mount_uploader :picture, PictureUploader

  def self.most_recent
    order("created_at DESC").limit(3)
  end

  private
  def twitter_has_valid_format
    match = twitter &&
      (twitter.match(/^([a-zA-Z0-9_]{1,15})$/) ||
       twitter.match(/^@([a-zA-Z0-9_]{1,15})$/) ||
       twitter.match(/^(http:\/\/)?www\.twitter\.com\/([a-zA-Z0-9_]{1,15})$/))

    if match
      self.twitter = match[-1]
    elsif twitter.present?
      errors.add(:twitter, :invalid)
    end
  end

end
