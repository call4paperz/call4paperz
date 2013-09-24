require 'spec_helper'

describe Comment do

  describe "mass assignment" do

    context "allowed" do
      [:body, :proposal_id].each do |attr|
        it { should allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :user_id, :created_at, :updated_at].each do |attr|
        it { should_not allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "validations" do

    describe "requireds" do
      it { should validate_presence_of(:body) }
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:proposal) }
  end
end
