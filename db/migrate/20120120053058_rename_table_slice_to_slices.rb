class RenameTableSliceToSlices < ActiveRecord::Migration
  def change
    rename_table :slice, :slices
  end
end
