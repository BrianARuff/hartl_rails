class User < ApplicationRecord
  before_save { self.email.downcase! } # works for update and # create

  validates(:name, presence: true, length: { minimum: 3, maximum: 50 })

  # REGEX stored in config/initializers/constants.rb file
  validates(:email, presence: true, length: { minimum: 3, maximum: 50 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: {
          case_sensitive: false })

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
