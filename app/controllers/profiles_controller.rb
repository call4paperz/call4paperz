class ProfilesController < ApplicationController
  before_filter :load_user, only: [:edit, :update]

  def show
    @profile = Profile.new current_user
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = I18n.t('flash.notice.profile_updated')
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :photo, :photo_cache)
  end
end
