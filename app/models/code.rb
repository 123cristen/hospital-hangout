class Code < ActiveRecord::Base
	attr_accessor :code_token
	belongs_to :hospital
	validates :hospital_id, presence: true

	# Returns true if the given code matches the digest.
  def authenticated?(code_token)
    return false if code_digest.nil?
    BCrypt::Password.new(code_digest).is_password?(code_token)
  end

  def new_digest
  	self.code_token = Code.new_token
  	update_attribute(:code_digest, Code.digest(code_token))
  end

  def Code.new_token
  	SecureRandom.urlsafe_base64
  end

  def Code.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
