class CreateDfTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :df_times do |t|
      t.integer       :d_sun,     null: false
      t.integer       :d_mon,     null: false
      t.integer       :d_tue,     null: false
      t.integer       :d_wed,     null: false
      t.integer       :d_thu,     null: false
      t.integer       :d_fri,     null: false
      t.integer       :d_sat,     null: false
      t.references    :textbook,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
