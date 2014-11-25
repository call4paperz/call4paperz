require 'spec_helper'

describe TwitterAvatarPromotion do
  let(:fulano) { FactoryGirl.create :user }
  let(:promoter) { TwitterAvatarPromotion.new fulano }

  it 'copy a valid twitter avatar' do
    fulano.twitter_avatar = 'http://localhost:3101/image_1.png'
    fulano.save!
    expect(promoter.promote).to eq true
    expect(fulano.photo.filename).to eq 'image_1.png'
  end

  it 'do not copy a invalid avatar' do
    fulano.twitter_avatar = 'http://localhost:3101/nothing-404'
    fulano.save!
    expect(promoter.promote).to eq false
    expect(fulano.photo?).to eq false
  end

  it 'do not override the current photo with twitter avatar' do
    fulano.twitter_avatar = 'http://localhost:3101/image_1.png'
    fulano.remote_photo_url = 'http://localhost:3101/image_2.png'
    fulano.save!
    promoter.promote
    expect(fulano.photo.filename).to eq 'image_2.png'
  end
end
