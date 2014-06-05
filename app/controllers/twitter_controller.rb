require 'twitter'

# this should be in an api namespace?
class TwitterController < ApplicationController
  def last
    respond_to do |format|
      format.json { render json: TwitterClient.new.last, serializer: TweetSerializer }
    end
  end

  end
end
