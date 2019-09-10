class Event < ApplicationRecord
  belongs_to :offer

  validates :start_time, :end_time, :offer_id, presence: true
end
