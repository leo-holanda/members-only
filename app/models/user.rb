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

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
                      
		def User.new_token
			SecureRandom.urlsafe_base64
		end

    def remember
      self.remember_digest = User.new_token
			update_attribute(:remember_digest, User.digest(remember_digest))
		end              
		
		def authenticated?(remember_token)
			return false if remember_digest.nil?
			BCrypt::Password.new(remember_digest).is_password?(remember_token)
		end

		def forget
			update_attribute(:remember_digest, nil)
		end
end