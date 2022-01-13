class SLearning < ApplicationRecord
  belongs_to :user
  has_many :textbooks

  validates :subject, presence: true
end
