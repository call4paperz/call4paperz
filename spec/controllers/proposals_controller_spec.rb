require 'spec_helper'

describe ProposalsController do

  def mock_proposal(stubs={})
    (@mock_proposal ||= mock_model(Proposal).as_null_object).tap do |proposal|
      proposal.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all proposals as @proposals" do
      Proposal.stub(:all) { [mock_proposal] }
      get :index
      assigns(:proposals).should eq([mock_proposal])
    end
  end

  describe "GET show" do
    it "assigns the requested proposal as @proposal" do
      Proposal.stub(:find).with("37") { mock_proposal }
      get :show, :id => "37"
      assigns(:proposal).should be(mock_proposal)
    end
  end

  describe "GET new" do
    it "assigns a new proposal as @proposal" do
      Proposal.stub(:new) { mock_proposal }
      get :new
      assigns(:proposal).should be(mock_proposal)
    end
  end

  describe "GET edit" do
    it "assigns the requested proposal as @proposal" do
      Proposal.stub(:find).with("37") { mock_proposal }
      get :edit, :id => "37"
      assigns(:proposal).should be(mock_proposal)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created proposal as @proposal" do
        Proposal.stub(:new).with({'these' => 'params'}) { mock_proposal(:save => true) }
        post :create, :proposal => {'these' => 'params'}
        assigns(:proposal).should be(mock_proposal)
      end

      it "redirects to the created proposal" do
        Proposal.stub(:new) { mock_proposal(:save => true) }
        post :create, :proposal => {}
        response.should redirect_to(proposal_url(mock_proposal))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved proposal as @proposal" do
        Proposal.stub(:new).with({'these' => 'params'}) { mock_proposal(:save => false) }
        post :create, :proposal => {'these' => 'params'}
        assigns(:proposal).should be(mock_proposal)
      end

      it "re-renders the 'new' template" do
        Proposal.stub(:new) { mock_proposal(:save => false) }
        post :create, :proposal => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested proposal" do
        Proposal.should_receive(:find).with("37") { mock_proposal }
        mock_proposal.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :proposal => {'these' => 'params'}
      end

      it "assigns the requested proposal as @proposal" do
        Proposal.stub(:find) { mock_proposal(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:proposal).should be(mock_proposal)
      end

      it "redirects to the proposal" do
        Proposal.stub(:find) { mock_proposal(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(proposal_url(mock_proposal))
      end
    end

    describe "with invalid params" do
      it "assigns the proposal as @proposal" do
        Proposal.stub(:find) { mock_proposal(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:proposal).should be(mock_proposal)
      end

      it "re-renders the 'edit' template" do
        Proposal.stub(:find) { mock_proposal(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested proposal" do
      Proposal.should_receive(:find).with("37") { mock_proposal }
      mock_proposal.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the proposals list" do
      Proposal.stub(:find) { mock_proposal }
      delete :destroy, :id => "1"
      response.should redirect_to(proposals_url)
    end
  end

end
