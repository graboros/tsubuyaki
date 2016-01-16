class AddTweetsCountToUsers < ActiveRecord::Migration

  def self.up

    add_column :users, :tweets_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :tweets_count

  end

end
