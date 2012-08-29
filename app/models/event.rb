class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  attr_accessor :crop_w, :crop_h, :crop_x, :crop_y, :prod_description

  has_many :proposals, :dependent => :destroy
  has_many :comments, :through  => :proposals
  has_many :votes, :through  => :proposals
  belongs_to :user

  validates_date :occurs_at, :on => :create, :on_or_after => :today

  validates_presence_of :name, :description, :occurs_at
  validates_associated :user
  validates_length_of :name, :within => 3..150
  validates_length_of :description, :within => 3..400

  before_validation :twitter_has_valid_format

  after_update :reprocess_photo, :if => :cropping?

  attr_accessible :crop_w, :crop_h, :crop_x, :crop_y,
    :picture_cache, :name, :description, :twitter,
    :occurs_at, :url, :user_id, :picture, :prod_description

  mount_uploader :picture, PictureUploader
  validate :honeypot

  class << self
    def most_recent
      order("created_at DESC").limit(3)
    end

    def occurs_first
      order("occurs_at ASC")
    end

    def active
      where('occurs_at >= ?', Date.today)
    end
  end

  def as_json(options=nil)
    super({
      :include => {
        :user => { :only => :name, :methods => [:picture] },
        :proposals => {
          :methods => [:votes_count, :comments_count, :acceptance_points,
                       :positive_points, :negative_points],
          :only => Proposal::JSON_ATTRIBUTES,
          :include => {:user => {:only => :name}}
        }
      },
      :methods => [:proposals_count, :votes_count, :comments_count]
    })
  end

  def proposals_count
    proposals.size
  end

  def votes_count
    votes.size
  end

  def comments_count
    comments.size
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  private
  def honeypot
    errors.add :prod_description, "lala" unless prod_description.blank?
  end

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

  def reprocess_photo
    picture.recreate_versions!
  end
end
