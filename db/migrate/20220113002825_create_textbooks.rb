class CreateTextbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :textbooks do |t|
      t.string      :book,             null: false
      t.integer     :s_page,           null: false
      t.integer     :e_page,           null: false
      t.date        :s_date,           null: false
      t.date        :e_date,           null: false
      t.references  :s_learning,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
