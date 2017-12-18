class EventCloseController < ApplicationController
  before_action :authenticate_user!
  before_action :event

  def edit
    if event.closed?
      render 'warning_reopen'
    else
      render 'warning_closing'
    end
  end

  def update
    if params[:close] == "true"
      event.close!
      redirect_to event_path(event), notice: t('flash.notice.closed')
    else
      event.reopen!
      redirect_to event_path(event), notice: t('flash.notice.reopened')
    end
  end

  private

  def event
    @event ||= current_user.events.find(params[:event_id])
  end
end
