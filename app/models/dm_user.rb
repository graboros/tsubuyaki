class DmUser < ActiveRecord::Base
  belongs_to :dm
  belongs_to :user

  scope :sent_to, ->(user) { where(user_id: user) }
  scope :sent_from, ->(user) { where.not(user_id: user)  }
end
