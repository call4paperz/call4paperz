require 'spec_helper'

describe "proposals/new.html.erb" do
  before(:each) do
    assign(:proposal, stub_model(Proposal,
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new proposal form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => proposals_path, :method => "post" do
      assert_select "input#proposal_name", :name => "proposal[name]"
      assert_select "textarea#proposal_description", :name => "proposal[description]"
      assert_select "input#proposal_user", :name => "proposal[user]"
    end
  end
end
