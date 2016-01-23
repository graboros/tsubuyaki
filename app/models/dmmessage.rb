class Dmmessage < ActiveRecord::Base
  belongs_to :dm, touch: true
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user, presence: true
  default_scope { order('created_at DESC') }
end
