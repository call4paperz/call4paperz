module ApplicationHelper
  def menu
    content_tag :ul, :id  => "menu_top" do
      content = ''
      content << content_tag(:li, link_to("Home", root_url))
      content << content_tag(:li, link_to("Events", events_path))
      if user_signed_in?
        content << content_tag(:li, link_to("Profile", profile_path))
        content << content_tag(:li, link_to("Logout", destroy_user_session_path))
      else
        content << content_tag(:li, link_to("Login", new_user_session_path))
      end
      content << image_tag ('/images/rr_icone.gif', :class => 'rr')
      content
    end
  end
end
