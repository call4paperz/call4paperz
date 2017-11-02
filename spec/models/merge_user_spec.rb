require 'spec_helper'

describe MergeUser, :type => :model do
  def build_associations(user, how_many)
    how_many.times do
      auth = Authentication.new
      auth.user_id = user.id
      user.authentications << auth
    end

    events = how_many.times.map { FactoryBot.create :event, user: user }
    proposals = events.map { |event| FactoryBot.create :proposal, user: user, event: event }
    proposals.map { |proposal| FactoryBot.create :comment, user: user, proposal: proposal }
    proposals.map { |proposal| FactoryBot.create :vote, user: user, proposal: proposal }
    user
  end

  subject(:merger) { MergeUser.new(joao_popular.email) }

  let!(:joao_popular) {
    user = FactoryBot.build(:user, name: 'Joao Popular')
    build_associations(user, 3)
  }
  let!(:menino_lambao) { build_associations(FactoryBot.build(:user, email: joao_popular.email), 2) }
  let!(:newbie) { build_associations(FactoryBot.build(:user, email: joao_popular.email), 1) }

  context 'moving all associations to the user with more previous associations' do
    it 'move the authentications' do
      authentications_to_merge = menino_lambao.authentications + newbie.authentications
      merger.merge
      expect(joao_popular.reload.authentications).to include(*authentications_to_merge)
    end

    it 'move the comments' do
      comments_to_merge = menino_lambao.comments + newbie.comments
      merger.merge
      expect(joao_popular.reload.comments).to include(*comments_to_merge)
    end

    it 'move the events' do
      events_to_merge = menino_lambao.events + newbie.events
      merger.merge
      expect(joao_popular.reload.events).to include(*events_to_merge)
    end

    it 'move the proposals' do
      proposals_to_merge = menino_lambao.proposals + newbie.proposals
      merger.merge
      expect(joao_popular.reload.proposals).to include(*proposals_to_merge)
    end

    it 'move the votes' do
      votes_to_merge = menino_lambao.votes + newbie.votes
      merger.merge
      expect(joao_popular.reload.votes).to include(*votes_to_merge)
    end
  end

  context 'moving avatars into the elected profile' do
    it 'move photo' do
      menino_lambao.photo = File.open(Rails.root + 'spec/fixtures/image_1.png')
      menino_lambao.save!
      merger.merge
      filename = Pathname.new(joao_popular.reload.photo.current_path).basename.to_s
      expect(filename).to eq 'image_1.png'
    end

    it 'do not touch photo if it already exists' do
      menino_lambao.photo = File.open(Rails.root + 'spec/fixtures/image_1.png')
      menino_lambao.save!
      joao_popular.photo = File.open(Rails.root + 'spec/fixtures/image_2.png')
      joao_popular.save!
      merger.merge
      filename = Pathname.new(joao_popular.reload.photo.current_path).basename.to_s
      expect(filename).to eq 'image_2.png'
    end
  end

  context 'removing old users' do
    it 'delete empty users after merge' do
      deleted_ids = [ menino_lambao.id, newbie.id ]
      merger.merge
      expect(User.where(id: deleted_ids).count).to eq 0
    end
  end

  context 'when the email is an empty string =(' do
    it 'do not tries to merge anything!' do
      merger = MergeUser.new('')
      expect(merger.merge).to eq false
    end
  end
end
