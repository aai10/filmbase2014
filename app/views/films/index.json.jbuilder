json.array!(@films) do |film|
  json.extract! film, :id, :name, :origin_name, :slogan, :country_id, :genre_id, :director_id, :length
  json.url film_url(film, format: :json)
end
