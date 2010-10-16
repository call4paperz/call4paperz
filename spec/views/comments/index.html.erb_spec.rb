require 'spec_helper'

describe "comments/index.html.erb" do
  before(:each) do
    assign(:comments, [
      stub_model(Comment),
      stub_model(Comment)
    ])
  end

  it "renders a list of comments" do
    render
  end
end
