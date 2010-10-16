class AuthenticationsController < ApplicationController

  def create
    auth = request.env["rack.auth"]
    authenticate!(auth['provider'], auth['uid'], auth['user_info'])
    redirect_to root_path, :notice => "Authentication with #{auth['provider']} successful."
  end

  private
  def authenticate!(provider, uid, user_info)
    authentication = Authentication.find_by_provider_and_uid(provider, uid)

    if authentication.blank?
      theuser = create_user(user_info)
      Rails.logger.info theuser.inspect
      sign_in(theuser) unless user_signed_in?
      Authentication.create(:provider => provider, :uid => uid, :user => current_user)
    else
      sign_in authentication.user unless user_signed_in?
    end
  end


  def create_user(user_info)
    User.create_from_oauth(:name => user_info['name'], :picture => user_info['image'])
  end
end
