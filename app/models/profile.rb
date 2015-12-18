class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :user_id, uniqueness: true

  def update_except_for_image(profile_params)
    self.update(introduction: profile_params[:introduction])
  end
end
