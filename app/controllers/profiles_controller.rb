class ProfilesController < ApplicationController
  before_filter :load_user, only: [:edit, :update, :resend_confirmation_email]

  def show
    @profile = Profile.new current_user
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:notice] = I18n.t('flash.notice.profile_updated')
      set_mail_changes if changed_email?
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

  def changed_email?
    user_params[:email].present?
  end

  def set_mail_changes
    flash[:notice] = I18n.t('flash.notice.profile_email_updated')
    force_send_confirmation_email if @user.email.blank?
  end

  def force_send_confirmation_email
    @user.send_confirmation_instructions
  end
end
