class ChangeDataRtextToRecords < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :r_text, :text
  end
end
