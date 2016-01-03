class Dm < ActiveRecord::Base

  has_many :dm_users, dependent: :destroy
  has_many :users, through: :dm_users
  has_many :dmmessages, dependent: :destroy

  def self.dmlist(user)
    Dm.all.select{|dm| dm.dm_users.map{|dm_users| dm_users.user_id}.include?(user.id)}
  end

  def self.find_or_create_by_users(users)
    unless users.present? 
      nil
    else
      dm = Dm.new
      users.each do |user|
        dm_user = dm.dm_users.build()
        dm_user.user = user
      end
      dm
    end
  end

  def add_content_with_user(content, user)
   self.dmmessages.build(content: content, user: user)
  end
end
