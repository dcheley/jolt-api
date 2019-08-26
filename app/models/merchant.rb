class Merchant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :offers

  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
