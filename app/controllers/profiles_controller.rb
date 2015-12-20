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
    result = current_user.profile.update_with_params(params)

    render 'edit'
  end

  def edit
  end

private
  def profile_params
    params.require(:profile).permit(:introduction, :image, :image_cache, :remove_image)
  end
end
