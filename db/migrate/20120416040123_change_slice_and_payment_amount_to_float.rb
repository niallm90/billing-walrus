class ChangeSliceAndPaymentAmountToFloat < ActiveRecord::Migration
  def change
    change_column :slices, :amount, :float
    change_column :payments, :amount, :float
  end
end
