class AuthenticationsController < ApplicationController

  def skip_store_location
    true
  end

  def create
    auth = request.env["rack.auth"]
    authenticate!(auth['provider'], auth['uid'], auth['user_info'])

    destination_url = stored_location_for(:user) || root_path
    redirect_to destination_url, :notice => "Welcome #{current_user.name}!"
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  private
  def authenticate!(provider, uid, user_info)
    authentication = Authentication.find_by_provider_and_uid(provider, uid)

    if authentication
      sign_in authentication.user unless user_signed_in?
    elsif current_user
      current_user.authentications.create(:provider => provider, :uid => uid)
    else
      user = User.new(:name => user_info['name'], :picture => user_info['image'])
      user.authentications.build(:provider => provider, :uid => uid)
      user.save!
      sign_in(user)
    end
  end

end
