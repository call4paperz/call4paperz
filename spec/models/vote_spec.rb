require 'spec_helper'

describe Vote do
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:user) { FactoryGirl.create(:user) }

  describe "mass assignment" do

    context "not allowed" do
      [:id, :direction, :proposal_id, :user_id, :created_at, :updated_at].each do |attr|
        it { should_not allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "validations" do

    describe "requireds" do
      it { should validate_presence_of(:direction) }
    end

    describe "proposal_id" do
      it { should validate_uniqueness_of(:proposal_id).scoped_to(:user_id) }
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:proposal) }
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
      vote.proposal.should == proposal
      vote.user.should == user
      vote.direction.should == Vote::LIKE
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
      vote.proposal.should == proposal
      vote.user.should == user
      vote.direction.should == Vote::DISLIKE
    end
  end
end
