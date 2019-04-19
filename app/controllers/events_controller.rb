class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :tags]
  before_action :check_profile_completion, except: [:index, :show, :tags]

  respond_to :html

  def index
    @events = Event.active.occurs_first.limit(100)
    respond_with @events
  end

  def tags
    @events = Event.active.tagged_with(params[:tag]).occurs_first.limit(100)
    respond_with @events
  end

  def show
    @event = Event.find_by_slug!(params[:id])

    # Unfortunately I can't get Rails to preload
    # users because of the crazy SQL involved.
    users_pair = User.find(@event.proposals.pluck('user_id')).map { |u| [u.id, u] }
    @users = Hash[users_pair]
    respond_with @event
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @event = load_user_event!(params[:id])
  end

  def create
    tag_list = event_params[:tag_list].split(", ")
    @event = current_user.events.build(event_params.merge!(tag_list: nil))
    @event.tag_list.add(tag_list)

    respond_to do |format|
      if verify_recaptcha(:model => @event, :message => 'Please type the captcha correctly') && @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @event = load_user_event!(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to(event_path(@event), :notice => 'Event was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # GET /events/1/crop
  def crop
    @event = load_user_event!(params[:id])
  end

  def destroy
    @event = Event.find_by_slug!(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :description, :occurs_at, :prod_description, :twitter, :url,
      :picture, :picture_cache, :tag_list
    )
  end

  def load_user_event!(slug)
    current_user.events.find_by_slug!(params[:id])
  end
end
