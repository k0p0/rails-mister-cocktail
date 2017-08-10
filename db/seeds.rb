# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require "json"

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

page = open(url)
contents = page.read
h = JSON.parse(contents)['drinks']

h.each do |r|
  Ingredient.create(name: "#{r['strIngredient1']}").save
end

url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"

page = open(url)
contents = page.read
h = JSON.parse(contents)['drinks']

h.each do |r|
  Cocktail.create(name: "#{r['strDrink']}").save
end

