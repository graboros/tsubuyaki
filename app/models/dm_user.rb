class DmUser < ActiveRecord::Base
  belongs_to :dm
  belongs_to :user
  validates :user, presence: true
end
