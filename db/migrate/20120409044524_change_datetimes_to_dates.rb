class ChangeDatetimesToDates < ActiveRecord::Migration
  def change
    change_table :bills do |t|
      t.change :issue_date, :date
      t.change :due_date, :date
    end
  end
end
