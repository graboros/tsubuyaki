class CreateDms < ActiveRecord::Migration
  def change
    create_table :dms do |t|
      t.timestamps null: false
    end
  end
end
