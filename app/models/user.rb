class User < ApplicationRecord
  has_secure_password

  has_many :merchants

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  scope :admin, -> { where(role: 2) }
  scope :merchant_admin, -> { where(role: 2) }
end
