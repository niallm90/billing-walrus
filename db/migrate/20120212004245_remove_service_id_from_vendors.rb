class RemoveServiceIdFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :service_id
  end
end
