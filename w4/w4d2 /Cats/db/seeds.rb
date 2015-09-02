# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Cat.create(birth_date: '1992-2-3', color: "brown", name: "jack", sex: "M", description: "I'm a cat" )
Cat.create(birth_date: '1998-2-3', color: "red", name: "jill", sex: "F", description: "I a cat" )
Cat.create(birth_date: '2000-2-3', color: "black", name: "jason", sex: "M", description: "I'm t" )
Cat.create(birth_date: '2001-2-3', color: "white", name: "jeff", sex: "F", description: "I cat" )
Cat.create(birth_date: '2005-2-3', color: "brown", name: "jon", sex: "M", description: "I'm a catsssss" )

CatRentalRequest.create!(cat_id: 1, start_date: "2003-2-3", end_date: "2003-2-5", status: nil )
CatRentalRequest.create!(cat_id: 1, start_date: "2003-2-3", end_date: "2003-2-6", status: nil )
CatRentalRequest.create!(cat_id: 1, start_date: "2003-2-5", end_date: "2003-2-7", status: nil )
