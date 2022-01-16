class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.date        :r_date,         null: false
      t.time        :r_time,         null: false
      t.integer     :r_page,         null: false
      t.integer     :r_text,         null: false
      t.references  :textbook,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
