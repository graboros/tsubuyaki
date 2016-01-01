class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sendto, class_name: "User", foreign_key: "sendto_id"
  validates :content, presence: true, length: { maximum: 140 }
end
