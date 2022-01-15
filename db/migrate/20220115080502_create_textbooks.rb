class CreateTextbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :textbooks do |t|
      t.string  :book,        null: false
      t.integer :s_page,      null: false
      t.integer :e_page,      null: false
      t.references :user,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
