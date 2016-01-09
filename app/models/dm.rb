class Dm < ActiveRecord::Base

  has_many :dm_users, dependent: :destroy
  has_many :users, through: :dm_users
  has_many :dmmessages, dependent: :destroy

  def self.find_or_create_by_users(users)
    unless users.present? 
      nil
    else
      dm = self.find_same_users_dm(users) || Dm.new
      if dm.new_record?
        users.each do |user|
          dm_user = dm.dm_users.build()
          dm_user.user = user
        end
      end
      dm
    end
  end

private
  def self.find_same_users_dm(users)
    Dm.all.select{|dm| dm.dm_users.map{|dm_user| dm_user.user_id}.to_set == users.map{|user| user.id}.to_set}.try(:first)
  end
end
