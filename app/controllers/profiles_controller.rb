class ProfilesController < ApplicationController
  before_filter :load_user, only: [:edit, :update]

  def show
    @events = current_user.events
  end

  def edit
  end

  def update
    if @user.update_attributes params[:user]
      flash[:notice] = 'User was successfully updated.'
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = current_user
  end
end
