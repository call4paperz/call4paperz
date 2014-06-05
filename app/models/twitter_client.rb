class TwitterClient
  def initialize(provider = nil)
    @provider = provider
  end

  def last
    TwitterClient::Tweet.new twitter.user_timeline("call4paperz", count: 1).first
  end

  private

  def twitter
    return @twitter ||= @provider.new if @provider
    @twitter ||= Twitter::REST::Client.new do |config|
      config.consumer_key     = ENV["TWITTER_ACCESS"]
      config.consumer_secret  = ENV["TWITTER_SECRET"]
    end
  end
end

class TwitterClient
  class Tweet
    extend Forwardable
    def_delegators :@tweet, :text, :created_at

    def initialize(tweet)
      @tweet = tweet
    end

    def created_at
      @tweet.created_at
    end

    def time_zone
      @tweet.try(:user).try(:time_zone) || "Brasilia"
    end

    # ActiveModel::Serializer contract
    def read_attribute_for_serialization(attr)
      send attr
    end
  end# Tweet
end
