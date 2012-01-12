class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.references :service
      t.string :name
      t.text :contact_details

      t.timestamps
    end
    add_index :vendors, :service_id
  end
end
