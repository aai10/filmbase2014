# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Страны
countries=HTTParty.get 'http://api.vk.com/method/database.getCountries?v=5.21&need_all=1&count=500'
countries['response']['items'].each do |attrs|
  Country.create!(name: attrs['title'])
end

#Жанры
genre_names=%w(Боевик Вестерн Детектив Драма Комедия Мелодрама Мистика Приключения Триллер Ужастик Фантастика Фэнтези)
genre_names.each do |name|
  Genre.create!(name: name)
end
