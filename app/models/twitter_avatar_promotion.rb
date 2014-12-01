# It moves promotes the twitter avatar to photo. If users have a twitter_avatar,
# but not a photo, this will give then a proper photo. The main goal is to be
# able to remove the twitter_avatar hack.
class TwitterAvatarPromotion
  def initialize(user)
    @user = user
  end

  def promote
    return if @user.photo? || !(avatar = @user.twitter_avatar)

    avatar = follow_redirect_on_fb_avatar(avatar)
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

  private

  def follow_redirect_on_fb_avatar(avatar)
    url = URI.parse(avatar)
    if url.to_s =~ /facebook\.com/
      req = Net::HTTP::Get.new(url.path)
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      case response
        when Net::HTTPRedirection
          return response['location']
      end
    end
    avatar
  end
end
