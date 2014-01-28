require 'spec_helper'

describe Event do

  describe "mass assignment" do

    context "allowed" do
      [:name, :description, :occurs_at, :picture, :url, :twitter, :user_id].each do |attr|
        it { should allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :created_at, :updated_at, :starts_votes_at, :end_votes_at, :slug,
       :proposals_count, :closed_at].each do |attr|
        it { should_not allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "validations" do

    describe "requireds" do
      [:name, :description, :occurs_at].each do |attr|
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
    it { should have_many(:comments).through(:proposals) }
    it { should have_many(:votes).through(:proposals) }
    it { should belong_to(:user) }
  end

  context ".occurs_first" do
    it "should sort the next to occur first" do
      late_event = FactoryGirl.create(:event, :occurs_at => 5.days.from_now)
      early_event = FactoryGirl.create(:event, :occurs_at => 1.day.from_now)

      described_class.occurs_first.should == [early_event, late_event]
    end
  end

  context ".active" do
    it "should find events from the future!" do
      ev = FactoryGirl.create(:event, :occurs_at => 5.days.from_now)
      described_class.active.should == [ev]
    end

    it "should include events from today" do
      ev = FactoryGirl.create(:event)
      described_class.active.should == [ev]
    end

    it "should not inclue events from the past" do
      Timecop.freeze(2.days.ago)
      ev = FactoryGirl.create(:event, :occurs_at => Time.current)
      Timecop.return

      described_class.active.should be_empty
    end
  end
end
