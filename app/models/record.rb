class Record < ApplicationRecord

  belongs_to :textbook

  with_options presence: true do
    validates :r_date
    validates :r_time
    validates :r_page
    validates :r_text
  end
end
