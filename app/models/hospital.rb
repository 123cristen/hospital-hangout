class Hospital < ActiveRecord::Base
	has_many :users

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
end
