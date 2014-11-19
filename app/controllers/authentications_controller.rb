class AuthenticationsController < ApplicationController
  def skip_store_location
    true
  end

  def create
    auth = request.env['omniauth.auth']
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

  def create_user_and_sign_in(authentication)
    if authentication.provider.to_s == 'twitter'
      redirect_to new_user_session_path, notice: I18n.t('auth.cant_create_twitter')
      false
    else
      user = authentication.create_user(request.env['omniauth.auth']['info'])
      sign_in(user)
      true
    end
  end

  def authentication
    auth_hash = request.env['omniauth.auth']
    @authentication ||=
      Authentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid']) ||
      Authentication.new(provider: auth_hash['provider'], uid: auth_hash['uid'])
  end

  def authenticate!(provider, uid, user_info)
    if authentication.persisted?
      sign_in authentication.user
    else
      create_user_and_sign_in(authentication)
    end
  end
end
