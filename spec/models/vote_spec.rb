require 'rails_helper'

describe Vote, :type => :model do
  let(:proposal) { FactoryBot.create(:proposal) }
  let(:user) { FactoryBot.create(:user) }

  describe "validations" do

    describe "requireds" do
      it { is_expected.to validate_presence_of(:direction) }
    end

    describe "proposal_id" do
      it { is_expected.to validate_uniqueness_of(:proposal_id).scoped_to(:user_id) }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:proposal) }
  end

  describe ".like" do
    it "should generate a vote for the specified proposal and user" do
      expect {
        described_class.like(proposal, user)
      }.to change(Vote, :count).by(1)
    end

    it "should set properties of vote correctly" do
      described_class.like(proposal, user)
      vote = Vote.last
      expect(vote.proposal).to eq(proposal)
      expect(vote.user).to eq(user)
      expect(vote.direction).to eq(Vote::LIKE)
    end
  end

  describe ".dislike" do
    it "should generate a vote for the specified proposal and user" do
      expect {
        described_class.dislike(proposal, user)
      }.to change(Vote, :count).by(1)
    end

    it "should set properties of vote correctly" do
      described_class.dislike(proposal, user)
      vote = Vote.last
      expect(vote.proposal).to eq(proposal)
      expect(vote.user).to eq(user)
      expect(vote.direction).to eq(Vote::DISLIKE)
    end
  end
end
