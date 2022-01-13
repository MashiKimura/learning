class Setting < ApplicationRecord
  belongs_to :user

  validates :s_day,   presence: trut
end
