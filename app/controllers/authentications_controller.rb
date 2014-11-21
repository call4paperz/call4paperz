class AuthenticationsController < ApplicationController
  def skip_store_location
    true
  end

  def create
    destination_url = stored_location_for(:user) || root_path

    if user_signed_in?
      auth = authentication(current_user.authentications)
      auth.save! unless auth.persisted?
      will_redirect = true
    else
      # As soon as we update the rails version, this will redirect will be
      # sacrificed to the gods of the good code.
      # It is here now because the redirect_to in our version doesn't do the
      # shortcircuit. And the authenticate! method, can call redirections.
      will_redirect = authenticate!
    end

    redirect_to destination_url, notice: "Welcome #{current_user.name}!" if will_redirect
  end

  def failure
    redirect_to root_url, notice: "Authentication error: #{params[:message].humanize}"
  end

  private

  def find_or_create_user_and_sign_in(authentication)
    if authentication.provider.to_s == 'twitter'
      redirect_to new_user_session_path, notice: I18n.t('auth.cant_create_twitter')
      false
    else
      user = User.find_or_create_with_authentication authentication
      sign_in(user)
      true
    end
  end

  def authentication(repo = Authentication)
    return @authentication if @authentication

    auth_hash = request.env['omniauth.auth']
    @authentication =
      repo.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid']) ||
      repo.new(provider: auth_hash['provider'], uid: auth_hash['uid'])
    @authentication.auth_info = auth_hash['info']
    @authentication
  end

  def authenticate!
    if authentication.persisted?
      sign_in authentication.user
    else
      find_or_create_user_and_sign_in(authentication)
    end
  end
end
