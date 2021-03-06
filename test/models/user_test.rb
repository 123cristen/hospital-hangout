require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user23@example.com",
    								password: "Foobar1", password_confirmation: "Foobar1", 
                    hospital_id: 1, code_token: "234234234")
    @hospital = Hospital.new(id: 1, name: "Example hospital")
    @code = Code.new(code_digest: Code.digest("234234234"), hospital_id: 1)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 100
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password validation should accept valid passwords" do
    valid_passwords = %w[Password1 NEWPaSSWORD345 2IsGood 
                           123456Hi eTC34578]
    valid_passwords.each do |valid_password|
      @user.password = valid_password
      @user.password_confirmation = valid_password
      assert @user.valid?, "#{valid_password.inspect} should be valid"
    end
  end

  test "password validation should reject invalid passwords" do
    invalid_passwords = %w[password 1234567 THISISGOOD foo+foo 
                           Password password1 ANOTHER1]
    invalid_passwords.each do |invalid_password|
      @user.password = invalid_password
      @user.password_confirmation = invalid_password
      assert_not @user.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end

  test "hospital field should not be empty" do
    @user.update_attribute(:hospital_id, nil)
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "code token should not be empty" do
    @user.update_attribute(:code_token, nil)
    assert_not @user.valid?
  end

  test "code token should be a valid code" do
    @user.update_attribute(:code_token, "this is not valid")
    assert_not @user.valid?
  end
end
