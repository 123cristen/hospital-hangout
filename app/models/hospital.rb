class Hospital < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 255 }
end
