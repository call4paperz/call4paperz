require 'spec_helper'

feature "Home", %q{
  In order make buzz about call4paperz
  As a visitor
  I want to be able to share to my friends
} do
  scenario "I should see a link to share to twitter" do
    visit '/'
    page.should have_css("a.twitter-share-button[data-url*='example.com']")
  end

  scenario "I should see a link to share to facebook" do
    visit '/'
    page.should have_css("a[share_url*='example.com']")
  end
end
