require 'spec_helper'

describe Event, :type => :model do

  describe "validations" do

    describe "requireds" do
      [:name, :description, :occurs_at].each do |attr|
        it { is_expected.to validate_presence_of(attr) }
      end
    end

    describe "name" do
      it { is_expected.to ensure_length_of(:name).is_at_least(3).is_at_most(150) }
    end

    describe "description" do
      it { is_expected.to ensure_length_of(:description).is_at_least(3).is_at_most(400) }
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:comments).through(:proposals) }
    it { is_expected.to have_many(:votes).through(:proposals) }
    it { is_expected.to belong_to(:user) }
  end

  context ".occurs_first" do
    it "should sort the next to occur first" do
      late_event = FactoryGirl.create(:event, :occurs_at => 5.days.from_now)
      early_event = FactoryGirl.create(:event, :occurs_at => 1.day.from_now)

      expect(described_class.occurs_first).to eq([early_event, late_event])
    end
  end

  context ".active" do
    it "should find events from the future!" do
      ev = FactoryGirl.create(:event, :occurs_at => 5.days.from_now)
      expect(described_class.active).to eq([ev])
    end

    it "should include events from today" do
      ev = FactoryGirl.create(:event)
      expect(described_class.active).to eq([ev])
    end

    it "should not inclue events from the past" do
      Timecop.freeze(2.days.ago)
      ev = FactoryGirl.create(:event, :occurs_at => Time.current)
      Timecop.return

      expect(described_class.active).to be_empty
    end
  end
end
