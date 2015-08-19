require 'test_helper'

class HospitalTest < ActiveSupport::TestCase

	def setup
		@hospital = Hospital.new(name: "Example Children's Hospital")
	end

	test "should_be_valid" do
		assert @hospital.valid?
	end

	test "name should be present" do
		@hospital.name = ("   ")
		assert_not @hospital.valid?
	end

	test "name should not be too long" do
		@hospital.name = "a" * 256
		assert_not @hospital.valid?
	end
end
