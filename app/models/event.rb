class Event < ApplicationRecord
  belongs_to :offer, optional: true

  validates :start_time, :end_time, presence: true
  validates :description, length: { maximum: 1000 } 
end
