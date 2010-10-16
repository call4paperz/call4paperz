module ApplicationHelper
  def menu
    content_tag :ul, :id  => "menu_top" do
      content = ''
      if user_signed_in?
        content << content_tag(:li, link_to("Logout", destroy_user_session_path))
      else
        content << content_tag(:li, link_to("Login Twitter", '/auth/twitter', :class => "auth_icon twitter_auth"))
        content << content_tag(:li, link_to("Login Facebook", '/auth/facebook', :class => "auth_icon facebook_auth"))
      end
      content << content_tag(:li, link_to("Events", events_path))
      content << content_tag(:li, link_to("Home", root_url))
      content
    end
  end
end




