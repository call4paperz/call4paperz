class HomeController < ApplicationController
  layout "home"
  
  def index
    @events = Event.most_recent
    @comments = Comment.most_recent
  end
end
