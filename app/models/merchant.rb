class Merchant < ApplicationRecord
  belongs_to :user, optional: true
  has_many :offers
  has_many :events, through: :offers
  has_many :advertisements
  has_many :billings

  validates :name, :category, presence: true
  validates :description, length: { maximum: 1000 }

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end
end
