class User < ApplicationRecord

    before_save { self.email.downcase! }

    VALID_NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
    validates :name, presence: true,
                     format: { with: VALID_NAME_REGEX },
                     length: { maximum: 50}

    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: URI::MailTo::EMAIL_REGEXP },
                      uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true,
                         length: { :within => 6..40 }
end