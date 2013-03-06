module EventsHelper
  def user_is_owner?(model)
    user = @users.present? ? @users[model.user_id] : model.user
    user == current_user
  end
end
