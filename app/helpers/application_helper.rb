module ApplicationHelper
  def menu
    content_tag :ul, :id  => "menu_top" do
      content = ''
      content << content_tag(:li, link_to("Home", root_url))
      content << content_tag(:li, link_to("Events", events_path))
      if user_signed_in?
        content << content_tag(:li, link_to("Profile", profile_path))
        content << content_tag(:li, link_to("Logout", destroy_user_session_path, :method => :delete))
      else
        content << content_tag(:li, link_to("Login", new_user_session_path))
      end
      content.html_safe
    end
  end

  def users_number
    User.count
  end

  def render_flash_notice
    if flash[:notice]
      content_tag :p, flash[:notice], class: "notice"
    end
  end
end
