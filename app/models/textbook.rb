class Textbook < ApplicationRecord

  belongs_to :user
  has_many :records, dependent: :destroy
  has_one :df_time, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :book, length: { maximum: 50 }
    validates :s_page, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }
    validates :e_page, numericality: { only_integer: true, greater_than: :s_page, less_than_or_equal_to: 9_999, message: "must be between StartPage to 9999" }, if: :present_s_page?
  end

  def present_s_page?
    s_page.present?
  end
end
