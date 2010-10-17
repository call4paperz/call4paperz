class ApplicationController < ActionController::Base
  protect_from_forgery

  def store_location
    return if skip_store_location
    
    if (request.get? && request.format.html? && !request.xhr? && !devise_controller?)
      session[:"user_return_to"] = request.request_uri 
    end 
    
    Rails.logger.info  session[:"user_return_to"]
  end
  
  def skip_store_location
    false
  end
  
end
