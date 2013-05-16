module EventsHelper
  def user_is_owner?(model)
    user_signed_in? && model.user == current_user
  end
end
