class Hospital < ActiveRecord::Base
	has_many :users
	has_many :codes
	after_save :create_codes
	before_save { email.downcase! }
	validates :name, presence: true, length: { maximum: 100 }
	validates :address_line_1, presence: true, length: { maximum: 100 }
	validates :city, presence: true, length: { maximum: 100 }
	validates :state, presence: true, length: { maximum: 2 }
	validates :zip, presence: true, length: { maximum: 10 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	VALID_PASSWORD_REGEX = /(?=.*\d)(?=.*[A-Z])(?=.*[a-z]).*/
  validate :password_complexity

  def create_codes
  	50.times do 
  		code = Code.create(hospital: self)
  		code.new_digest
  	end
  end

  def password_complexity
    if !password.match(VALID_PASSWORD_REGEX)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end

  def Hospital.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
