class Dm < ActiveRecord::Base

  has_many :dm_users, dependent: :destroy
  has_many :users, through: :dm_users
  has_many :dm_messages, dependent: :destroy

  validates :dm_users, presence: true

  def self.find_or_initialize_by_users(current_user, users)
    raise StandardError if users.blank?

    self.find_same_users_dm(current_user, users << current_user) || Dm.new do |dm|
      users.each do |user|
        dm_user = dm.dm_users.build()
        dm_user.user = user
      end
    end
  end

private
  def self.find_same_users_dm(current_user, users)
    user_ids = users.map(&:id).to_set

    current_user.dms.detect{|dm|
      dm.dm_users.map(&:user_id).to_set == user_ids
    }
  end
end
