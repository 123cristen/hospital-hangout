require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def signup 
    @hospital = Hospital.new( id: 1,
                          name: "Example Children's Hospital",
                          email: "hospital@example.com",
                          password: "Password1",
                          password_confirmation: "Password1",
                          address_line_1: "5 Main Street",
                          address_line_2: "",
                          city: "Los Angeles",
                          state: "CA",
                          zip: "90024")
    @code = Code.create(code_digest: Code.digest("234234234"), hospital_id: 1)
  end

  test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "",
															email: "user@invalid",
															hospital_id: nil,
                              code_token: nil,
															password: "foo",
															password_confirmation: "bar" }
		end
		assert_template 'users/new'
    assert_select 'input.error'
    assert_select 'small.error'
	end

	test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user3@example.com",
                                            hospital_id: 1,
                                            code_token: "234234234",
                                            password:              "Password1",
                                            password_confirmation: "Password1" }
    end
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
