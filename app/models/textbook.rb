class Textbook < ApplicationRecord

  belongs_to :user

  with_options presence: true do
    validates :book
    validates :s_page
    validates :e_page
  end
end
