class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid

  attr_accessor :auth_info
  [ :name, :image, :email ].each do |_method|
    define_method _method do
      auth_info[_method.to_s]
    end
  end
end
