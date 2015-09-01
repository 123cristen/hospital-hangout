# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User to login as:
User.create!(name: "Example User",
							email: "user@example.com",
							hospital_id: 1;
							password: "Password1",
							password_confirmation: "Password1")

# Hospital to login as:
Hospital.create!(name: "Example Children's Hospital",
									email: "hospital@example.com",
									password: "Password1",
									password_confirmation: "Password1",
									address_line_1: "5 Main Street",
									address_line_2: "",
									city: "Los Angeles",
									state: "CA",
									zip: "90024")

# Create lots of users
100.times do
	User.create!(name: Faker::Name.name,
									email: Faker::Internet.email,
									hospital_id: 1;
									password: "Password1",
									password_confirmation: "Password1")
end

# Create lots of hospitals
20.times do
	Hospital.create!(name: Faker::Address.city + " Children's Hospital",
									email: Faker::Internet.email,
									password: "Password1",
									password_confirmation: "Password1",
									address_line_1: Faker::Address.street_address,
									address_line_2: Faker::Address.secondary_address,
									city: Faker::Address.city,
									state: Faker::Address.state_abbr,
									zip: Faker::Address.zip)
end

# Assign each user a hospital
User.all.each do |user|
	user.update_attribute(:hospital, Hospital.find(user.id%20+1))
end
