class User < ApplicationRecord
  has_secure_password
  belongs_to :organization

  validates :first_name, presence: true
  validates :last_name, presence: true
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }, allow_nil: true, allow_blank: true
end
