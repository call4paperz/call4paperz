require 'spec_helper'

describe "events/edit.html.erb" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :picture => "MyString",
      :url => "MyString",
      :twitter => "MyString",
      :user => nil
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => event_path(@event), :method => "post" do
      assert_select "input#event_name", :name => "event[name]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "input#event_picture", :name => "event[picture]"
      assert_select "input#event_url", :name => "event[url]"
      assert_select "input#event_twitter", :name => "event[twitter]"
      assert_select "input#event_user", :name => "event[user]"
    end
  end
end
