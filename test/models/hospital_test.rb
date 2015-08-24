require 'test_helper'

class HospitalTest < ActiveSupport::TestCase

	def setup
		@hospital = Hospital.new(name: "Example Children's Hospital",
															email: "hospital@example.com",
															password: "Password1",
															password_confirmation: "Password1",
															address_line_1: "5 Main Street",
															address_line_2: "",
															city: "Los Angeles",
															state: "CA",
															zip: "90024")
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

	test "email should be present" do
    @hospital.email = "     "
    assert_not @hospital.valid?
  end

  test "email should not be too long" do
    @hospital.email = "a" * 244 + "@example.com"
    assert_not @hospital.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @hospital.email = valid_address
      assert @hospital.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @hospital.email = invalid_address
      assert_not @hospital.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_hospital = @hospital.dup
    duplicate_hospital.email = @hospital.email.upcase
    @hospital.save
    assert_not duplicate_hospital.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @hospital.email = mixed_case_email
    @hospital.save
    assert_equal mixed_case_email.downcase, @hospital.reload.email
  end

  test "password should be present (nonblank)" do
    @hospital.password = @hospital.password_confirmation = " " * 6
    assert_not @hospital.valid?
  end

  test "password should have a minimum length" do
    @hospital.password = @hospital.password_confirmation = "a" * 5
    assert_not @hospital.valid?
  end

  test "password validation should accept valid passwords" do
    valid_passwords = %w[Password1 NEWPaSSWORD345 2IsGood 
                           123456Hi eTC34578]
    valid_passwords.each do |valid_password|
      @hospital.password = valid_password
      @hospital.password_confirmation = valid_password
      assert @hospital.valid?, "#{valid_password.inspect} should be valid"
    end
  end

  test "password validation should reject invalid passwords" do
    invalid_passwords = %w[password 1234567 THISISGOOD foo+foo 
                           Password password1 ANOTHER1]
    invalid_passwords.each do |invalid_password|
      @hospital.password = invalid_password
      @hospital.password_confirmation = invalid_password
      assert_not @hospital.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end
end
