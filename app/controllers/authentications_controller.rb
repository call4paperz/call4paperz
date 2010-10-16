class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    auth = request.env["rack.auth"]

    # Rails.logger.debug auth.to_yaml
    Authentication.authenticate!(auth['provider'], auth['uid'])


    redirect_to root_path, :notice => "Authentication with #{auth['provider']} successful."
  end

end
