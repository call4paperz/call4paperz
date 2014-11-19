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
  def sign_in_with_authentication(authentication)
    if user_signed_in?
      current_user.authentications.create(provider: authentication.provider, uid: uid)
    else
      sign_in authentication.user
    end
    true
  end

  def sign_in_with_twitter(uid)
    if user_signed_in?
      current_user.authentications.create(provider: 'twitter', uid: uid)
      true
    else
      redirect_to new_user_session_path, notice: I18n.t('auth.cant_create_twitter')
      false
    end
  end

  def create_authentication_and_sign_in(provider, uid, auth_info)
    user = User.create_from_auth_info(provider, uid, auth_info)
    sign_in(user)
    true
  end

  def create_authentication(provider, uid, auth_info)
    if provider.to_s == 'twitter'
      sign_in_with_twitter(uid)
    else
      create_authentication_and_sign_in(provider, uid, auth_info)
    end
  end

  def authenticate!(provider, uid, user_info)
    auth_hash = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if authentication
      sign_in_with_authentication(authentication)
    else
      create_authentication(provider, uid, auth_hash['info'])
    end
  end
end
