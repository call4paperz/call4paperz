class HomeController < ApplicationController
  layout "home"

  def index
    @events = Event.most_recent
    @comments = Comment.most_recent.includes(:user, :proposal)
    @events_quantity = Event.count
  end

end
