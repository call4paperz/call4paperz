require 'spec_helper'

describe "comments/show.html.erb" do
  before(:each) do
    @comment = assign(:comment, stub_model(Comment))
  end

  it "renders attributes in <p>" do
    render
  end
end
