class Offer < ApplicationRecord
  belongs_to :merchant
  has_many :events

  validates :title, :dollar_value, :merchant_id, presence: true
end
