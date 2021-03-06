class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :user, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 60 }

  def update_with_params(params)
    if params[:image].present?
      self.update(params)
    else
      self.update_except_for_image(params)
    end
  end

  def update_except_for_image(profile_params)
    self.update(introduction: profile_params[:introduction])
  end
end
