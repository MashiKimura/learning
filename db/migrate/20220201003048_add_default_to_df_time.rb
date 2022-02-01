class AddDefaultToDfTime < ActiveRecord::Migration[6.0]
  def change
    change_column :df_times, :d_sun, :integer, default: 0, null: false
    change_column :df_times, :d_mon, :integer, default: 0, null: false
    change_column :df_times, :d_tue, :integer, default: 0, null: false
    change_column :df_times, :d_wed, :integer, default: 0, null: false
    change_column :df_times, :d_thu, :integer, default: 0, null: false
    change_column :df_times, :d_fri, :integer, default: 0, null: false
    change_column :df_times, :d_sat, :integer, default: 0, null: false
  end
end
