class AddFollowingsCountToUsers < ActiveRecord::Migration

  def self.up

    add_column :users, :followings_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :followings_count

  end

end
