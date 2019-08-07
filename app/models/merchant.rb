class Merchant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :promotions

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
