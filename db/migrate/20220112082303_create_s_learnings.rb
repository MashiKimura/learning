class CreateSLearnings < ActiveRecord::Migration[6.0]
  def change
    create_table :s_learnings do |t|
      t.string      :subject,   null: false
      t.date        :g_date,    null: false
      t.references  :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
