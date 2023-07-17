# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :profile_info, only: %i[edit update]
  def edit
    @my_profile = UserProfileForm.new(current_user, profile: @profile)
  end

  def update
    @my_profile = UserProfileForm.new(current_user, profile_params, profile: @profile)

    if @my_profile.save
      redirect_to profile_path
      flash[:success] = 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  private

  def profile_info
    @profile = current_user.profile
  end

  def profile_params
    params.require(:user_profile_form).permit(:nickname, :bio, :location, :website, :icon, :header, :date_of_birth)
  end
end
