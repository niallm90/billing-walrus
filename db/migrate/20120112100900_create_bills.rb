class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :vendor
      t.datetime :issue_date
      t.datetime :due_date

      t.timestamps
    end
    add_index :bills, :vendor_id
  end
end
