require 'twitter'

# this should be in an api namespace?
class TwitterController < ApplicationController
  def last
    respond_to do |format|
      format.json { render json: last_tweet, serializer: TweetSerializer }
    end
  end

  private

  def last_tweet
    Rails.cache.fetch "last_tweet", expires_in: 20.minutes do
      TwitterClient.new.last
    end
  end
end
