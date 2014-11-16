require 'spec_helper'

describe MergeUser do
  def build_associations(user, how_many)
    events = how_many.times.map { FactoryGirl.create :event, user: user }
    proposals = events.map { |event| FactoryGirl.create :proposal, user: user, event: event }
    proposals.map { |proposal| FactoryGirl.create :comment, user: user, proposal: proposal }
    proposals.map { |proposal| FactoryGirl.create :vote, user: user, proposal: proposal }
    user
  end

  subject(:merger) { MergeUser.new(joao_popular.email) }

  let!(:joao_popular) {
    user = FactoryGirl.build(:user, name: 'Joao Popular')
    build_associations(user, 3)
  }
  let!(:menino_lambao) { build_associations(FactoryGirl.build(:user, email: joao_popular.email), 2) }
  let!(:newbie) { build_associations(FactoryGirl.build(:user, email: joao_popular.email), 1) }

  it 'moves all the associations to the more "associated" user' do
    events_to_merge = menino_lambao.events + newbie.events
    merger.merge
    expect(joao_popular.reload.events).to include(*events_to_merge)
  end
end
