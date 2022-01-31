class DfTime < ApplicationRecord

  belongs_to :textbook

  with_options presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 23 } do
    validates :d_sun
    validates :d_mon
    validates :d_tue
    validates :d_wed
    validates :d_thu
    validates :d_fri
    validates :d_sat
  end
end
