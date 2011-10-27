module UserHelper
  def user_picture(user, options={})
    if user.present?
      if user.email?
        image_tag user.gravatar_url(:default => root_url + path_to_image('no_avatar.png'))
      else
        image_tag user.picture, options
      end
    else
      image_tag 'no_avatar.png', options
    end
  end
end
