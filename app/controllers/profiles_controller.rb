class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.profile.update_with_params(profile_params)
      redirect_to edit_user_profile_url(current_user), notice: 'プロフィールを更新しました'
    else
      redirect_to edit_user_profile_url(current_user), alert: 'プロフィールの更新に失敗しました'
    end
  end

  def edit
  end

private
  def profile_params
    params.require(:profile).permit(:introduction, :image, :image_cache, :remove_image)
  end
end
