# It moves promotes the twitter avatar to photo. If users have a twitter_avatar,
# but not a photo, this will give then a proper photo. The main goal is to be
# able to remove the twitter_avatar hack.
class TwitterAvatarPromotion
  def initialize(user)
    @user = user
  end

  def promote
    return unless @user.photo? || avatar = @user.twitter_avatar
    @user.remote_photo_url = avatar
    begin
      @user.save!
      true
    rescue ActiveRecord::RecordInvalid => e
      message = @user.errors['photo'].first
      unless message && message.include?('not download')
        raise e
      end
      false
    end
  end
end
