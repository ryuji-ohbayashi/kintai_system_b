class User < ApplicationRecord
  before_save { self.email = email.downcase } # 4.4.6
  
  validates :name, presence: true, length: { maximum: 50 } # 4.4.1 / 4.4.3
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # 4.4.4
  validates :email, presence: true, length: { maximum: 100 }, # 4.4.2 / 4.4.3
                    format: { with: VALID_EMAIL_REGEX }, # 4.4.4
                    uniqueness: true
  has_secure_password # 4.5
  validates :password, presence: true, length: { minimum: 6 } # 4.5.1
end