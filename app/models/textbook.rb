class Textbook < ApplicationRecord

  belongs_to :s_learning

  with_options presence: true do
    validates :book
    validates :s_page
    validates :e_page
    validates :s_date
    validates :e_date
  end
end
