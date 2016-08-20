class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        notice = 'Comment was successfully created.'
      else
        notice = 'Comment was invalid.'
      end

      format.html do
        redirect_to([@comment.proposal.event, @comment.proposal],
          notice: notice)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :proposal_id)
  end
end
