class Feedback < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: { maximum: 1000 }
end
