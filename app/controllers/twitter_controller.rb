require 'twitter'

class TwitterController < ApplicationController
  def tweets
    @tweets = {
      response: last_tweets
    }

    respond_to do |format|
      format.json { render json: @tweets }
    end
  end

  def last_tweets
    Twitter.user_timeline("call4paperz", count: 3)
  end
end