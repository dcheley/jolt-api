class Billing < ApplicationRecord
  belongs_to :merchant

  validates :first_name, :last_name, :institution, :credit_card_number, :credit_expiary_date, :cvv, presence: true
end
