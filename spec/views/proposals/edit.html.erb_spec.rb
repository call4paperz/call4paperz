require 'spec_helper'

describe "proposals/edit.html.erb" do
  before(:each) do
    @proposal = assign(:proposal, stub_model(Proposal,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders the edit proposal form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => proposal_path(@proposal), :method => "post" do
      assert_select "input#proposal_name", :name => "proposal[name]"
      assert_select "textarea#proposal_description", :name => "proposal[description]"
      assert_select "input#proposal_user", :name => "proposal[user]"
    end
  end
end
