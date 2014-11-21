require 'spec_helper'

describe Profile do
  it 'delegate equality notions to user' do
    user1 = User.new
    user2 = User.new
    profile1 = Profile.new user1
    profile2 = Profile.new user2
    profile3_user1 = Profile.new user1

    expect(profile1).to eq profile1
    expect(profile1).to eq profile3_user1
    expect(profile1).to_not eq profile2
  end
end
