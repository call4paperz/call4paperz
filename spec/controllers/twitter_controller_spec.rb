require "spec_helper"

describe TwitterController do

  let(:last_tweets) { 
    [{ 
      id_str: "240859602684612608",
      created_at: "Wed Aug 29 17:12:58 +0000 2013",
      text: "@leonardocbs it should be fine now, we needed to comply to Facebook's most recent privacy policy. Thanks!",
      user: {
        screen_name: "call4paperz"
      }
    }]
  }

  describe "last tweets" do
    it "should get last tweet from call4paperz timeline" do
      controller.stub(:last_tweets).and_return(last_tweets)

      get :tweets, format: :json

      expected = { response: last_tweets }.to_json

      response.should be_success
      response.body.should == expected
    end
  end

end
