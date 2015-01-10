# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

User.destroy_all
Idea.destroy_all

10.times do
  User.create(username: Faker::Internet::user_name, password: "123456", password_confirmation: "123456")
end

50.times do
  Idea.create(
    title:   Faker::Movie::title,
    content: Faker::Lorem::sentence(100),
    creator: User.all.sample(1)[0]
  )
end
