require 'spec_helper'

describe "events/new.html.erb" do
  before(:each) do
    assign(:event, stub_model(Event,
      :name => "MyString",
      :description => "MyText",
      :picture => "MyString",
      :url => "MyString",
      :twitter => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "input#event_picture", :name => "event[picture]"
      assert_select "input#event_url", :name => "event[url]"
      assert_select "input#event_twitter", :name => "event[twitter]"
      assert_select "input#event_user", :name => "event[user]"
    end
  end
end
