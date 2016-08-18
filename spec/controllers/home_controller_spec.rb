require 'spec_helper'

RSpec.describe HomeController do
  describe 'GET #index' do
    let(:most_recent_events) { [double(:recent_event)] }
    let(:comments) { [double(:comment)] }
    let(:events_quantity) { 10 }

    before do
      expect(Event).to receive(:most_recent).and_return(most_recent_events)
      expect(Comment).to receive_message_chain(:most_recent, :includes).and_return(comments)
      expect(Event).to receive_message_chain(:active, :count).and_return(events_quantity)

      get :index
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'assigns instance variables' do
      expect(assigns(:events)).to eq(most_recent_events)
      expect(assigns(:comments)).to eq(comments)
      expect(assigns(:events_quantity)).to eq(events_quantity)
    end
  end
end
