module UserHelper
  def user_picture(user, options={})
    if user.present? && user.email?
      image_tag user.gravatar_url(:default => root_url + path_to_image('no_avatar.png'))
    else
      image_tag 'no_avatar.png', options
    end
  end
end
