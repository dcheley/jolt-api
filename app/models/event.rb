class Event < ApplicationRecord
  belongs_to :offer

  validates :start_time, :end_time, :description, :offer_id, presence: true
  validates :description, length: { maximum: 1000 }
end
