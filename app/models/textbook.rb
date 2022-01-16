class Textbook < ApplicationRecord

  belongs_to :user
  has_many :records

  with_options presence: true do
    validates :book
    validates :s_page
    validates :e_page
  end
end
