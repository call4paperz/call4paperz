class HomeController < ApplicationController

  def index
    @events = Event.most_recent
    @comments = Comment.most_recent.includes(:user, :proposal)
    @events_quantity = Event.active.count
  end

  def about
  end

end
