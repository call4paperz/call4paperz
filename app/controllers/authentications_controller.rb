class AuthenticationsController < ApplicationController
  def skip_store_location
    true
  end

  def create
    auth = request.env["omniauth.auth"]
    if authenticate!(auth['provider'], auth['uid'], auth['user_info'])
      destination_url = stored_location_for(:user) || root_path
      redirect_to destination_url, :notice => "Welcome #{current_user.name}!"
    end
  end

  def failure
    redirect_to root_url, :notice => "Authentication error: #{params[:message].humanize}"
  end

  private

  def authenticate!(provider, uid, user_info)
    auth_hash = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

    if authentication
      sign_in authentication.user unless user_signed_in?
      true
    elsif current_user
      current_user.authentications.create(:provider => provider, :uid => uid)
      true
    else
      if provider.to_s == 'twitter'
        redirect_to new_user_session_path, notice: I18n.t('auth.cant_create_twitter')
        false
      else
        user = User.create_from_auth_info(provider, uid, auth_hash['info'])
        sign_in(user)
        true
      end
    end
  end
end
