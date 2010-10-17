class ProfileController < ApplicationController

  def show
    @events = Event.where("user_id = #{current_user.id}")
  end
  
end
