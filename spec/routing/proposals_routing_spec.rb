require "spec_helper"

describe ProposalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/proposals" }.should route_to(:controller => "proposals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/proposals/new" }.should route_to(:controller => "proposals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/proposals/1" }.should route_to(:controller => "proposals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/proposals/1/edit" }.should route_to(:controller => "proposals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/proposals" }.should route_to(:controller => "proposals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/proposals/1" }.should route_to(:controller => "proposals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/proposals/1" }.should route_to(:controller => "proposals", :action => "destroy", :id => "1")
    end

  end
end
