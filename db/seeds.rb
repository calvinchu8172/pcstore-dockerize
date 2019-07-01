# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_category category
  category = Category.create!(
    name: category,
    is_enabled: false,
    is_deleted: false
  )
  category
end

def create_product category, product, file
  product = Product.create!( 
    name: product,
    description: "#{product} of #{category.name}",
    price: rand(10..1000),
    is_online: true,
    image: Pathname.new(Rails.root.join("db/seed_pics/#{category.name}/#{file}")).open,
    is_recycled: false,
    category_id: category.id
  )  
end

Dir.chdir("./db/seed_pics")
categories = Dir.glob("**")
categories.each do | category |
  puts "Creating category #{category}..."
  category = create_category category

  Dir.chdir(category.name)
  files = Dir.glob("**")
  files = files.sort_by(&:to_i)
  files.each do |file|
    product = file.split('.')[0]
    puts "Creating product #{product} of category #{category.name}..."
    create_product category, product, file
  end

  Dir.chdir("../")
end

