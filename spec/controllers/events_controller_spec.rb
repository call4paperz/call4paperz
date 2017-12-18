require 'rails_helper'

describe EventsController, :type => :controller do
  context 'Signed in but without email' do
    include HelperMethods::Controllers

    describe 'GET /new' do
      it 'redirects to profile edition' do
        user = sign_in_user_without_email(request)
        get 'new'
        expect(response).to redirect_to(edit_profile_path(user))
      end
    end

    #TODO: spec the other actions that need profile completion check
  end
end
