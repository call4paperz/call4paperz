require "spec_helper"

describe TwitterClient do
  let(:tweet_inteface) {
    OpenStruct.new(
      created_at: Time.new(2013, 8, 29),
      text: %Q{@leonardocbs it should be fine now, we needed to comply to
        Facebook's most recent privacy policy. Thanks!}
    )
  }

  describe "#last" do
    let(:provider_instance) {
      instance = double "a twitter client instance"
      allow(instance).to receive(:user_timeline).and_return [tweet_inteface]
      instance
    }

    let(:provider) {
      provider = double "a twitter client class"
      allow(provider).to receive(:new).and_return provider_instance
      provider
    }

    it "calls #user_timeline on a provider instance to fetch the last tweet" do
      last_tweet = TwitterClient.new(provider).last
      expect(last_tweet.text).to eq tweet_inteface.text
      expect(last_tweet.created_at).to eq tweet_inteface.created_at
    end

    it "passes 'call4paperz', and 'count: 1' for user_timeline" do
      expect(provider_instance).to receive(:user_timeline).
        with("call4paperz", count: 1)
      TwitterClient.new(provider).last
    end

    it "defaults to Twitter::REST::Client when none provider is given" do
      expect(Twitter::REST::Client).to receive(:new).and_return provider_instance
      TwitterClient.new.last
    end
  end
end

describe TwitterClient::Tweet do
  let(:tweet_inteface) {
    OpenStruct.new(
      created_at: Time.new(2013, 8, 29),
      text: %Q{@leonardocbs it should be fine now, we needed to comply to
        Facebook's most recent privacy policy. Thanks!}
    )
  }
  let(:tweet) { TwitterClient::Tweet.new tweet_inteface }

  it "uses an internal object with #created_at and #text to represent a tweet" do
    expect(tweet.created_at).to eq tweet_inteface.created_at
    expect(tweet.text).to eq tweet_inteface.text
  end

  describe "#time_zone" do
    it "defaults to 'Brasilia' if none (user or) timezone is given" do
      expect(tweet.time_zone).to eq "Brasilia"
    end

    it "uses an internal #user.time_zone to retrieve timezone if available" do
      tweet = TwitterClient::Tweet.new OpenStruct.new(
        user: OpenStruct.new(time_zone: "user/timezone")
      )
      expect(tweet.time_zone).to eq "user/timezone"
    end
  end
end
