class AddAccessLevelToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :access_level
    end
  end
end
