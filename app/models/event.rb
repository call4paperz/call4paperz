class Event < ActiveRecord::Base
  has_many :proposals, :dependent => :destroy
  has_many :comments, :through  => :proposals
  has_many :votes, :through  => :proposals
  belongs_to :user

  validates_date :occurs_at, :on => :create, :on_or_after => :today

  validates_presence_of :name, :description, :occurs_at
  validates_associated :user

  mount_uploader :picture, PictureUploader

  def self.most_recent
    order("created_at DESC").limit(3)
  end

end
