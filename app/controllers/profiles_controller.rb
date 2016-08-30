class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user, only: [:edit, :update, :resend_confirmation_email]
  before_filter :store_location, only: :show

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

  def resend_confirmation_email
    flash[:notice] = I18n.t('flash.notice.profile_email_confirmation_sent')
    force_send_confirmation_email
    redirect_to edit_profile_path(@user)
  end

  private

  def load_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :photo, :photo_cache)
  end

  def force_send_confirmation_email
    @user.send_confirmation_instructions
  end
end
