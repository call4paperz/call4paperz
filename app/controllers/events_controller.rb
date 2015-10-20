class EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :check_profile_completion, except: [:index, :show]

  respond_to :html, :json, :jsonp

  # GET /events
  # GET /events.xml
  def index
    @events = Event.active.occurs_first.limit(100)
    respond_with @events
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find_by_slug!(params[:id])

    # Unfortunately I can't get Rails to preload
    # users because of the crazy SQL involved.
    users_pair = User.find(@event.proposals.pluck('user_id')).map { |u| [u.id, u] }
    @users = Hash[users_pair]
    respond_with @event
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = current_user.events.find_by_slug!(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if verify_recaptcha(:model => @event, :message => 'Please type the captcha correctly') && @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = current_user.events.find_by_slug!(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /events/1/crop
  def crop
    @event = current_user.events.find_by_slug!(params[:id])
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find_by_slug!(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :occurs_at, :prod_description, :twitter, :url, :picture, :picture_cache)
  end
end
