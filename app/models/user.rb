class User < ApplicationRecord
  has_secure_password

  has_many :merchants

  validates :email, presence: true
  validates :email, uniqueness: true
end
