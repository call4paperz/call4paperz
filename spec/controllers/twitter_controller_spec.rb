require "spec_helper"

RSpec.describe TwitterController, :type => :controller do
  let(:last_tweet) {
    TwitterClient::Tweet.new OpenStruct.new(
      created_at: Time.new(2013, 8, 29),
      text: %Q{@leonardocbs it should be fine now, we needed to comply to
        Facebook's most recent privacy policy. Thanks!})
  }

  before do
    tw_client = double "Twitter Rest Client"
    allow(tw_client).to receive(:last).and_return last_tweet
    allow(TwitterClient).to receive(:new).and_return(tw_client)
  end

  describe "last tweets" do
    xit "should get last tweet from call4paperz timeline" do
      get :last, format: :json
      expect(response).to be_success
      expect(response.body).to eq TweetSerializer.new(last_tweet).to_json
    end
  end

end
