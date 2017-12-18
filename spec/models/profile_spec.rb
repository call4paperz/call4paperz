require 'rails_helper'

describe Profile, :type => :model do
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

  it 'returns all user\'s non associated auth methods' do
    user = User.new
    user.authentications = [ Authentication.new(provider: :twitter) ]
    profile = Profile.new user
    providers = profile.unassociated_providers.map { |provider| provider.name.to_sym }
    expect(providers).to_not include :twitter
  end

  it 'recognizes `:google` as `:google_oauth2`' do
    user = User.new
    user.authentications = [ Authentication.new(provider: :google_oauth2) ]
    profile = Profile.new user
    providers = profile.unassociated_providers.map { |provider| provider.name.to_sym }
    expect(providers).to_not include :google, :google_oauth2
  end
end
