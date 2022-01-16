class AddHoursToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :hours, :integer
    add_column :records, :minutes, :integer
  end
end
