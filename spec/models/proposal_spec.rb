require 'spec_helper'

describe Proposal, :type => :model do

  let(:proposal) { FactoryBot.create(:proposal)  }

  describe "validations" do

    describe "requireds" do
      [:name, :description].each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end

    describe "name" do
      it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(150) }
    end

    describe "description" do
      it { is_expected.to validate_length_of(:description).is_at_least(3).is_at_most(400) }
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end

  describe "preloads comments count" do
    it "preloads the count" do
      3.times { FactoryBot.create(:comment, :proposal => proposal)}

      proposal_from_db = described_class.with_preloads.find(proposal.id)
      expect(proposal_from_db.attributes['comments_count'].to_i).to eq(3)
    end
  end

  describe "acceptance points" do
    context "preloading acceptance points" do
      it "assigns acceptance points as attribute" do
        FactoryBot.create(:negative_vote, :proposal => proposal)
        3.times { FactoryBot.create(:positive_vote, :proposal => proposal)}

        proposal_from_db = described_class.with_preloads.find(proposal.id)
        expect(proposal_from_db.attributes['acceptance_points'].to_i).to eq(2)
        expect(proposal_from_db.acceptance_points).to eq(2)
      end

      it "orders by acceptance points" do
        FactoryBot.create(:negative_vote, :proposal => proposal)
        3.times { FactoryBot.create(:positive_vote, :proposal => proposal)}

        another_proposal = FactoryBot.create(:proposal)
        3.times { FactoryBot.create(:positive_vote, :proposal => another_proposal)}

        first_proposal, second_proposal = described_class.with_preloads

        expect(first_proposal).to eq(another_proposal)
        expect(first_proposal.acceptance_points).to eq(3)

        expect(second_proposal).to eq(proposal)
        expect(second_proposal.acceptance_points).to eq(2)
      end

      it "includes proposals with no votes" do
        lonely_proposal = FactoryBot.create(:proposal)

        expect(described_class.with_preloads).to include(lonely_proposal)
      end
    end

    context "no votes" do
      it "should return 0" do
        expect(proposal.acceptance_points).to eq(0)
      end
    end

    context "with more positive than negative votes" do
      it "returns a positive value" do
        FactoryBot.create(:negative_vote, :proposal => proposal)
        3.times { FactoryBot.create(:positive_vote, :proposal => proposal)}

        expect(proposal.acceptance_points).to eq(2)
      end
    end

    context "with more negative than positive votes" do
      it "returns a negative value" do
        FactoryBot.create(:positive_vote, :proposal => proposal)
        3.times { FactoryBot.create(:negative_vote, :proposal => proposal)}

        expect(proposal.acceptance_points).to eq(-2)
      end
    end

    context "with no negative votes" do
      it "returns a positive value" do
        FactoryBot.create(:positive_vote, :proposal => proposal)
        expect(proposal.acceptance_points).to eq(1)
      end
    end
  end

  describe "grace period calculation" do
    context "with grace period left" do
      let(:proposal) { FactoryBot.build(:proposal, :created_at => 10.minutes.ago) }

      it "returns the number of seconds of grace period" do
        expect(proposal).to have_grace_period_left
        expect(proposal.grace_period_left).to be_within(2).of(1200)
      end
    end

    context "with no grace period left" do
      let(:old_proposal) { FactoryBot.build(:proposal, :created_at => 30.days.ago) }

      it "returns 0 as grace period" do
        expect(old_proposal).not_to have_grace_period_left
        expect(old_proposal.grace_period_left).to be(0)
      end
    end
  end
end
