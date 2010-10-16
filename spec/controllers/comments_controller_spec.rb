require 'spec_helper'

describe CommentsController do

  def mock_comment(stubs={})
    (@mock_comment ||= mock_model(Comment).as_null_object).tap do |comment|
      comment.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all comments as @comments" do
      Comment.stub(:all) { [mock_comment] }
      get :index
      assigns(:comments).should eq([mock_comment])
    end
  end

  describe "GET show" do
    it "assigns the requested comment as @comment" do
      Comment.stub(:find).with("37") { mock_comment }
      get :show, :id => "37"
      assigns(:comment).should be(mock_comment)
    end
  end

  describe "GET new" do
    it "assigns a new comment as @comment" do
      Comment.stub(:new) { mock_comment }
      get :new
      assigns(:comment).should be(mock_comment)
    end
  end

  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      Comment.stub(:find).with("37") { mock_comment }
      get :edit, :id => "37"
      assigns(:comment).should be(mock_comment)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created comment as @comment" do
        Comment.stub(:new).with({'these' => 'params'}) { mock_comment(:save => true) }
        post :create, :comment => {'these' => 'params'}
        assigns(:comment).should be(mock_comment)
      end

      it "redirects to the created comment" do
        Comment.stub(:new) { mock_comment(:save => true) }
        post :create, :comment => {}
        response.should redirect_to(comment_url(mock_comment))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        Comment.stub(:new).with({'these' => 'params'}) { mock_comment(:save => false) }
        post :create, :comment => {'these' => 'params'}
        assigns(:comment).should be(mock_comment)
      end

      it "re-renders the 'new' template" do
        Comment.stub(:new) { mock_comment(:save => false) }
        post :create, :comment => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested comment" do
        Comment.should_receive(:find).with("37") { mock_comment }
        mock_comment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comment => {'these' => 'params'}
      end

      it "assigns the requested comment as @comment" do
        Comment.stub(:find) { mock_comment(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:comment).should be(mock_comment)
      end

      it "redirects to the comment" do
        Comment.stub(:find) { mock_comment(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(comment_url(mock_comment))
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        Comment.stub(:find) { mock_comment(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:comment).should be(mock_comment)
      end

      it "re-renders the 'edit' template" do
        Comment.stub(:find) { mock_comment(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      Comment.should_receive(:find).with("37") { mock_comment }
      mock_comment.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the comments list" do
      Comment.stub(:find) { mock_comment }
      delete :destroy, :id => "1"
      response.should redirect_to(comments_url)
    end
  end

end
