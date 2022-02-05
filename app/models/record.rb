class Record < ApplicationRecord
  belongs_to :textbook

  validates :r_text, length: { maximum: 150 }

  with_options presence: true do
    validates :r_date
    validates :r_page, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9_999 }
    validates :hours, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 23 }
    validates :minutes, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 59 }
  end

  validate :hours_and_minutes_zero
  validate :textbook_page

  def hours_and_minutes_zero
    if hours == 0 && minutes == 0
      errors.add(:hours,"and Minutes be can't blank")
    end
  end

  def textbook_page
    textbook = Textbook.find(textbook_id)
    if (r_page <= textbook.s_page) || (r_page >= textbook.e_page)
      errors.add(:r_page,"must be between start and end")
    end
  end
end
