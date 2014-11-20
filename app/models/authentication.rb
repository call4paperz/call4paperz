class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid

  attr_accessor :auth_info
  [ :name, :image, :email ].each do |_method|
    define_method _method do
      auth_info[_method.to_s]
    end
  end

  def create_user
    user = User.new(name: name, remote_photo_url: image)
    if email
      user.email = email
      user.confirmed_at = Time.now
    end
    user.authentications = [ self ]
    user.save!
    user
  end
end
