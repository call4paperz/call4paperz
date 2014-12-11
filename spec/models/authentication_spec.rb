require 'spec_helper'

describe Authentication, :type => :model do

  describe "mass assignment" do

    context "allowed" do
      [:provider, :uid].each do |attr|
        it { is_expected.to allow_mass_assignment_of(attr) }
      end
    end

    context "not allowed" do
      [:id, :user_id, :created_at, :updated_at].each do |attr|
        it { is_expected.not_to allow_mass_assignment_of(attr) }
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
