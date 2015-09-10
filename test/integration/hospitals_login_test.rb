require 'test_helper'

class HospitalsLoginTest < ActionDispatch::IntegrationTest
	def setup 
		@hospital = hospitals(:example)
	end

	test "login with invalid information" do 
		get hospital_login_path
		assert_template 'hospital_sessions/new'
		post hospital_login_path, session: { hospital_id: "", password: "" }
		assert_template 'hospital_sessions/new'
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "login with valid information followed by logout" do
		get hospital_login_path
		post hospital_login_path, session: { hospital_id: @hospital.id, password: 'Password1'}
		assert is_h_logged_in?
		assert_redirected_to @hospital
		follow_redirect!
		assert_template 'hospitals/show'
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", hospital_path(@hospital)
		delete hospital_logout_path
		assert_not is_h_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select "a[href=?]", login_path
		assert_select "a[href=?]", logout_path, count: 0
		assert_select "a[href=?]", hospital_path(@hospital), count: 0
	end
end
