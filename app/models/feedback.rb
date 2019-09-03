class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :merchant, optional: true

  validates :message, presence: true, length: { maximum: 1000 }
end
