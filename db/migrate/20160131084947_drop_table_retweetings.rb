class DropTableRetweetings < ActiveRecord::Migration
  def change
    drop_table :retweetings
  end
end
