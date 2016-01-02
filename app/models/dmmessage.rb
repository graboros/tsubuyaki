class Dmmessage < ActiveRecord::Base
  belongs_to :dm
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
end
