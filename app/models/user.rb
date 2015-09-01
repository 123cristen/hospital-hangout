class User < ActiveRecord::Base
	belongs_to :hospital

	before_save { email.downcase! }
	validates :name, presence: true, length: { maximum: 60 }
	validates :hospital_id, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
	VALID_PASSWORD_REGEX = /(?=.*\d)(?=.*[A-Z])(?=.*[a-z]).*/
  validate :password_complexity
  validates :password_confirmation, presence: true

  def password_complexity
    if password.nil? || !password.match(VALID_PASSWORD_REGEX)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter, and one digit"
    end
  end
end
