class HomeController < ApplicationController
  layout "home"

  def index
    @events = Event.most_recent
    @comments = Comment.most_recent
    @events_quantity = Event.count
    @latest_tweet = Twitter.user('call4paperz')["status"]["text"]
  end
end
