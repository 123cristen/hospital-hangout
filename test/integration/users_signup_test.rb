require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "",
															email: "user@invalid",
															hospital: nil,
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
                                            email: "user2@example.com",
                                            hospital_id: 1,
                                            password:              "Password1",
                                            password_confirmation: "Password1" }
    end
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
