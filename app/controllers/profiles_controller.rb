class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.save

    render 'edit'
  end

  def update
    params = profile_params
    if params[:image].present?
      result = current_user.profile.update(params)
    else
      result = current_user.profile.update_except_for_image(params)
    end

    render 'edit'
  end

  def edit
  end

private
  def profile_params
    params.require(:profile).permit(:introduction, :image, :image_cache, :remove_image)
  end
  # FIXME: idが自分じゃなかったら404みたいなのを入れる
  # def set_user
  #   @user = User.find(params[:id])
  # end
end
