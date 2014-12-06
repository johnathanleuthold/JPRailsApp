# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ingredients = Ingredient.create([{name: 'Butter'},
                                 {name: 'Flour'},
                                 {name: 'Sugar'},
                                 {name: 'Brown Sugar'},
                                 {name: 'Eggs'},
                                 {name: 'Vanilla'},
                                 {name: 'Baking Soda'},
                                 {name: 'Salt'},
                                 {name: 'Chocolate Chips'}])

measurements = Measurement.create([{name: 'Cup', abbr: 'C'},
                                   {name: 'Teaspoon', abbr: 't'},
                                   {name: 'Tablespoon', abbr: 'T'},
                                   {name: 'Pound', abbr: 'lb'}])
tester = User.create([{username: 'Test1', email: 'test@1.com', fname: 'Test', lname: '1', password: 'peanut', password_confirmation: 'peanut'},
                     {username: 'Test2', email: 'test@2.com', fname: 'Test', lname: '2', password: 'peanut', password_confirmation: 'peanut'}] )










