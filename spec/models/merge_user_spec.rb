require 'spec_helper'

describe MergeUser do
  def build_associations(user, how_many)
    events = 3.times.map { FactoryGirl.create :events, user: user }
    proposals = events.map { |event| FactoryGirl.create :proposals, user: user, event: event }
    proposals.map { |proposal| FactoryGirl.create :comments, user: user, proposal: proposal }
    proposals.map { |proposal| FactoryGirl.create :events, user: user, proposal: proposal }
    user
  end

  let(:joao_popular) { build_associations(FactoryGirl.build(:user), 3) }
  let(:menino_lambao) { build_associations(FactoryGirl.build(:user), 2) }
  let(:newbie) { build_associations(FactoryGirl.build(:user), 1) }

  it 'moves all the associations to the more "associated" user' do
    expect(joao_popular.events).to include(menino_lambao.events + newbie.events)
  end
end
