class ProposalsController < ApplicationController
  before_filter :event
  before_filter :authenticate_user!, :only => [:create, :new, :update, :destroy, :edit, :dislike, :like]
  before_filter :verify_grace_period, :only => [:update, :edit]
  before_filter :verify_event_closed, only: [:new, :create]
  before_filter :check_profile_completion, only: [:create, :new, :update, :destroy, :edit]

  respond_to :html, :json

  # GET /proposals/1
  # GET /proposals/1.xml
  def show
    @comments = proposal.comments.includes(:user).order("created_at DESC")

    @comment = Comment.new
    @comment.proposal = proposal

    respond_with @proposal
  end

  # GET /proposals/new
  # GET /proposals/new.xml
  def new
    @proposal = Proposal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proposal }
    end
  end

  # GET /proposals/1/edit
  def edit
    proposal
  end

  # POST /proposals
  # POST /proposals.xml
  def create
    @proposal = Proposal.new(params[:proposal])
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

  # PUT /proposals/1
  # PUT /proposals/1.xml
  def update
    respond_to do |format|
      if proposal.update_attributes(params[:proposal])
        format.html { redirect_to(@proposal, :notice => 'Proposal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proposal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.xml
  def destroy
    proposal.destroy

    respond_to do |format|
      format.html { redirect_to(proposals_url) }
      format.xml  { head :ok }
    end
  end

  def like
    if Vote.like(proposal, current_user)
      notice = 'You liked the proposal.'
    else
      notice = t('proposals.likes.fail')
    end

    respond_to do |format|
      if request.xhr?
        format.html { render proposal, layout: false }
      else
        format.html { redirect_to(event_url(event), notice: notice) }
      end
    end
  end

  def dislike
    if Vote.dislike(proposal, current_user)
      notice = 'You disliked the proposal.'
    else
      notice = t('proposals.dislikes.fail')
    end

    respond_to do |format|
      if request.xhr?
        format.html { render proposal, layout: false }
      else
        format.html { redirect_to(event_url(event), notice: notice) }
      end
    end
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
end
