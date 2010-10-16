class HomeController < ApplicationController
  def index
    @events = Event.most_recent
    @comments = Comment.most_recent
  end
end
