require "spec_helper"

RSpec.describe ProposalsController, :type => :controller do
  let(:event) { FactoryBot.build_stubbed(:event) }

  before do
    sign_in FactoryBot.create(:user)
    allow(controller).to receive(:event) { event }
  end

  describe "new proposal" do
    it "does not allow to show the form for new proposals for closed events" do
      allow(event).to receive(:closed?) { true }

      get :new, params: { event_id: 123 }

      expect(response).to redirect_to(event)
    end
  end

  describe "create proposal" do
    it "does not allow to create new proposals for closed events" do
      allow(event).to receive(:closed?) { true }

      post :create, params: { event_id: 123 }

      expect(response).to redirect_to(event)
    end
  end

  #TODO: maybe this should be a shared example
  context 'Singed in but without email' do
    include HelperMethods::Controllers

    describe 'GET /new' do
      it 'redirects to profile edition' do
        user = sign_in_user_without_email(request)
        get :new, params: { event_id: 123 }
        expect(response).to redirect_to(edit_profile_path(user))
      end
    end

    #TODO: spec the other actions that need profile completion check
  end
end
