module UserHelper
  def user_picture(user, options={})
    if user.present? and user.picture.present?
      image_tag user.picture.thumb, options
    else
      image_tag 'no_avatar.png', options
    end
  end
end
