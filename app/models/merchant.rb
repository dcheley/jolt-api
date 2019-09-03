class Merchant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :offers
  has_many :promotions,
  has_one :billing

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
