class RemoveHoursFromRecords < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :r_time, :time
  end
end
