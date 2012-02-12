class CreateServicesVendorsTable < ActiveRecord::Migration
  def change
    create_table :services_vendors do |t|
      t.references :service
      t.references :vendor
    end
  end
end
