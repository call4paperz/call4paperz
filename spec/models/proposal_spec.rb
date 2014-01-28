require 'spec_helper'

describe Proposal do

  let(:proposal) { FactoryGirl.create(:proposal)  }

  describe "mass assignment" do

    context "allowed" do
      [:name, :description, :user_id, :created_at, :updated_at, :comments_count].each do |attr|
        it { should allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :event_id].each do |attr|
        it { should_not allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "validations" do

    describe "requireds" do
      [:name, :description].each do |attr|
        it { should validate_presence_of(attr) }
      end
    end

    describe "name" do
      it { should ensure_length_of(:name).is_at_least(3).is_at_most(150) }
    end

    describe "description" do
      it { should ensure_length_of(:description).is_at_least(3).is_at_most(400) }
    end
  end

  describe "associations" do
    it { should have_many(:votes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe "preloads comments count" do
    it "preloads the count" do
      3.times { FactoryGirl.create(:comment, :proposal => proposal)}

      proposal_from_db = described_class.with_preloads.find(proposal.id)
      proposal_from_db.attributes['comments_count'].to_i.should == 3
    end
  end

  describe "acceptance points" do
    context "preloading acceptance points" do
      it "assigns acceptance points as attribute" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        proposal_from_db = described_class.with_preloads.find(proposal.id)
        proposal_from_db.attributes['acceptance_points'].to_i.should == 2
        proposal_from_db.acceptance_points.should == 2
      end

      it "orders by acceptance points" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        another_proposal = FactoryGirl.create(:proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => another_proposal)}

        first_proposal, second_proposal = described_class.with_preloads

        first_proposal.should == another_proposal
        first_proposal.acceptance_points.should == 3

        second_proposal.should == proposal
        second_proposal.acceptance_points.should == 2
      end

      it "includes proposals with no votes" do
        lonely_proposal = FactoryGirl.create(:proposal)

        described_class.with_preloads.should include(lonely_proposal)
      end
    end

    context "no votes" do
      it "should return 0" do
        proposal.acceptance_points.should == 0
      end
    end

    context "with more positive than negative votes" do
      it "returns a positive value" do
        FactoryGirl.create(:negative_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:positive_vote, :proposal => proposal)}

        proposal.acceptance_points.should == 2
      end
    end

    context "with more negative than positive votes" do
      it "returns a negative value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        3.times { FactoryGirl.create(:negative_vote, :proposal => proposal)}

        proposal.acceptance_points.should == -2
      end
    end

    context "with no negative votes" do
      it "returns a positive value" do
        FactoryGirl.create(:positive_vote, :proposal => proposal)
        proposal.acceptance_points.should == 1
      end
    end
  end

  describe "grace period calculation" do
    context "with grace period left" do
      let(:proposal) { FactoryGirl.build(:proposal, :created_at => 10.minutes.ago) }

      it "returns the number of seconds of grace period" do
        proposal.should have_grace_period_left
        proposal.grace_period_left.should be_within(2).of(1200)
      end
    end

    context "with no grace period left" do
      let(:old_proposal) { FactoryGirl.build(:proposal, :created_at => 30.days.ago) }

      it "returns 0 as grace period" do
        old_proposal.should_not have_grace_period_left
        old_proposal.grace_period_left.should be(0)
      end
    end
  end
end
