class RenameDmmessages < ActiveRecord::Migration
  def change
    rename_table :dmmessages, :dm_messages
  end
end
