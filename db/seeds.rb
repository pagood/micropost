# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_list =[
	['hello@vistor.com','123456']
]
user_list.each do |email,password|
	user = User.create(email: email,password: password,activated: true, activated_at: Time.now,user_name: 'vistor')
	user.follow User.last
end
