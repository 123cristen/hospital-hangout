# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#include Faker

100.times do
	User.create!(name: Faker::Name.name,
									email: Faker::Internet.email,
									password: "password",
									password_confirmation: "password")
end

20.times do
	Hospital.create!(name: Faker::Name.name + "'s Hospital",
									email: Faker::Internet.email,
									password: "password",
									password_confirmation: "password")
end
