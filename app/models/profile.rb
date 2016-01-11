class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :user_id, presence: true, uniqueness: true
  validates :introduction, length: { maximum: 60 }

  def update_with_params(params)
    if params[:image].present?
      result = self.update(params)
    else
      result = self.update_except_for_image(params)
    end
    result
  end

  def update_except_for_image(profile_params)
    self.update(introduction: profile_params[:introduction])
  end
end
