class Authentication < ActiveRecord::Base
  belongs_to :user


  class << self

    def authenticate!(provider, uid)
      authentication = Authentication.find_by_provider_and_uid(provider, uid)

      if authentication.blank?
        sign_in(User.create) unless user_signed_in?
        Authentication.create(:provider => provider, :uid => uid, :user => current_user)
      else
        sign_in authentication.user unless user_signed_in?
      end
    end
  end
end
