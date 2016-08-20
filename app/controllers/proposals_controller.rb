class ProposalsController < ApplicationController
  before_filter :event
  before_filter :authenticate_user!, :only => [:create, :new, :update, :destroy, :edit, :dislike, :like]
  before_filter :verify_grace_period, :only => [:update, :edit]
  before_filter :verify_event_closed, only: [:new, :create]
  before_filter :check_profile_completion, only: [:create, :new, :update, :destroy, :edit]

  respond_to :html, :json

  def show
    @comments = proposal.comments.includes(:user).order("created_at DESC")

    @comment = Comment.new
    @comment.proposal = proposal

    respond_with @proposal
  end

  def new
    @proposal = Proposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proposal }
    end
  end

  def edit
    proposal
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user = current_user
    @proposal.event = event

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to(@event, :notice => 'Proposal was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if proposal.update_attributes(proposal_params)
        format.html { redirect_to(@proposal, :notice => 'Proposal was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    proposal.destroy

    respond_to do |format|
      format.html { redirect_to(proposals_url) }
    end
  end

  def like
    hash = {
      success_message: t('proposals.likes.success'),
      fail_message:    t('proposals.likes.fail'),
      action:          :like
    }

    vote_action(hash)
  end

  def dislike
    hash = {
      success_message: t('proposals.dislikes.success'),
      fail_message:    t('proposals.dislikes.fail'),
      action:          :dislike
    }

    vote_action(hash)
  end

  private
  def event
    @event ||= Event.find params[:event_id]
  end

  def proposal
    @proposal ||= Proposal.find(params[:id])
  end

  def verify_event_closed
    redirect_to event if event.closed?
  end

  def verify_grace_period
    unless proposal.has_grace_period_left?
      redirect_to [event, proposal], :notice => "You cannot edit a proposal after 30 minutes of creation."
    end
  end

  def proposal_params
    params.require(:proposal).permit(:name, :description)
  end

  def vote_action(hash)
    if Vote.send(hash[:action], proposal, current_user)
      notice = hash[:success_message]
    else
      notice = hash[:fail_message]
    end

    redirect_to(event_url(event), notice: notice)
  end
end
