require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  # An user that haven't provide an email, have to do it now.
  before_filter do
    check_for_email_presence if user_signed_in?
  end

  def store_location
    return if skip_store_location

    if (request.get? && request.format.html? && !request.xhr? && !devise_controller?)
      session[:'user_return_to'] = request.request_uri
    end

    Rails.logger.info session[:'user_return_to']
  end

  def skip_store_location
    false
  end

  private
  def profile_completing?
    params['controller'] == 'profiles' &&
       (params['action'] == 'update' || params['action'] == 'edit')
  end

  def check_for_email_presence
    need_completion = !current_user.email.present?
    if need_completion && !profile_completing?
      redirect_to edit_profile_path(current_user)
    end
  end
end
