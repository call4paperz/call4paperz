require "spec_helper"

describe ProposalsController do
  let(:event) { FactoryGirl.build_stubbed(:event) }

  before do
    sign_in FactoryGirl.create(:user)

    controller.stub(event: event)
  end

  describe "new proposal" do
    it "does not allow to show the form for new proposals for closed events" do
      event.stub(closed?: true)

      get :new, event_id: 123

      response.should redirect_to(event)
    end
  end

  describe "create proposal" do
    it "does not allow to create new proposals for closed events" do
      event.stub(closed?: true)

      post :create, event_id: 123

      response.should redirect_to(event)
    end
  end
end
