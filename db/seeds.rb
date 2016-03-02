# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_list =[
	['217xiaoyu@gmail.com','123456'],
	['217xiaoyu@sina.com','123456'],
	['1712736@qq.com','123456'],
	['yx774@nyu.edu','123456'],
]
user_list.each do |email,password|
	User.create(email: email,password: password)
end
