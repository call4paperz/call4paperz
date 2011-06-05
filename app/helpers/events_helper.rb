module EventsHelper
  def user_is_owner?(model)
    model.user == current_user
  end
end
