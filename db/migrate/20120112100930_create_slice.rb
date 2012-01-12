class CreateSlice < ActiveRecord::Migration
  def change
    create_table :slice do |t|
      t.references :user
      t.references :bill
      t.integer :amount

      t.timestamps
    end
    add_index :slice, :user_id
    add_index :slice, :bill_id
  end
end
