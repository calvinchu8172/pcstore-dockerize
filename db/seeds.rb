# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = ['書 book', '畫 paint', '車 car', '玩具 toy', '包 bag', '高級品 luxury']
categories.each do | category |
  puts "category #{category} creating..."
  Category.create(name: category)
end


