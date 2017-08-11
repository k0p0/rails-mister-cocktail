puts "destroy all ingredients and cocktails"

Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

puts "create ingredient"

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
h = JSON.parse(open(url).read)['drinks']
h.each do |r|
  Ingredient.create(name: "#{r['strIngredient1']}").save
end

puts "create cocktail"
url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
h = JSON.parse(open(url).read)['drinks']

h.each do |r|
  c = Cocktail.create(name: "#{r['strDrink']}")

  # p ">>>> #{r['strDrinkThumb']}"

  if r['strDrinkThumb'] == ""
    c.remote_photo_url ="http://res.cloudinary.com/lmdn/image/upload/v1502459936/cocktail-vide_egqvkg.jpg"
  else
    c.remote_photo_url = r['strDrinkThumb']
  end
  c.save

  url = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{r['idDrink']}"
  h2 = JSON.parse(open(url).read)['drinks']

  puts "adding #{c.name}"
  i = 1
  h2.each do |a|
    c.instruction = a["strInstructions"]
    c.save
    (1..15).each do
      if a["strMeasure#{i}"] != ""
        d = Dose.new
        d.description = a["strMeasure#{i}"]
        d.ingredient = Ingredient.find_by_name(a["strIngredient#{i}"])
        d.cocktail = c
        d.save
      end
      i += 1
    end
  end
end
