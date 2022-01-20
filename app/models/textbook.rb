class Textbook < ApplicationRecord

  belongs_to :user
  has_many :records
  has_one_attached :image

  with_options presence: true do
    validates :book
    validates :s_page
    validates :e_page
  end
end
