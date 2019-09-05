class Advertisement < ApplicationRecord
  belongs_to :merchant

  validates :title, :dollar_value, :merchant_id, presence: true
end
