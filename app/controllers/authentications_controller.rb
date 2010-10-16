class AuthenticationsController < ApplicationController

  def create
    render :text => request.env["rack.auth"].to_yaml
  end

end
