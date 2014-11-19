class AuthenticationsController < ApplicationController
  def skip_store_location
    true
  end

  def create
    auth = request.env["omniauth.auth"]
    destination_url = stored_location_for(:user) || root_path

    if user_signed_in?
      current_user.authentications.create(provider: auth['provider'], uid: auth['uid'])
      will_redirect = true
    else
      # As soon as we update the rails version, this will redirect will be
      # sacrificed to the gods of the good code.
      # It is here now because the redirect_to in our version doesn't do the
      # shortcircuit. And the authenticate! method, can call redirections.
      will_redirect = authenticate!(auth['provider'], auth['uid'], auth['user_info'])
    end

    redirect_to destination_url, notice: "Welcome #{current_user.name}!" if will_redirect
  end

  def failure
    redirect_to root_url, notice: "Authentication error: #{params[:message].humanize}"
  end

  private

  def create_authentication_and_sign_in(provider, uid, auth_info)
    if provider.to_s == 'twitter'
      redirect_to new_user_session_path, notice: I18n.t('auth.cant_create_twitter')
      false
    else
      user = User.create_from_auth_info(provider, uid, auth_info)
      sign_in(user)
      true
    end
  end

  def authenticate!(provider, uid, user_info)
    auth_hash = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if authentication
      sign_in authentication.user
      true
    else
      create_authentication_and_sign_in(provider, uid, auth_hash['info'])
    end
  end
end
