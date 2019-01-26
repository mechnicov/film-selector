require_relative 'lib/kinopoisk'
require_relative 'lib/movies_collection'
require_relative 'lib/movie'

JSON_PATH = "#{__dir__}/data/.json".freeze

user_key = nil
until %w(и л).include? user_key
  puts "# Подобрать фильм из:\n" \
       "   - (И)нтернета\n" \
       "   - (л)окального списка (информация могла устареть)"
  user_key = STDIN.gets.chomp.downcase
end

if user_key == 'и'
  puts "\nИдёт обработка данных сайта kinopoisk.ru. Ожидайте окончания..."
  collection, source = MoviesCollection.from_kinopoisk, 'с сайта kinopoisk.ru'
else
  collection, source = MoviesCollection.from_json(JSON_PATH), 'в папке data'
end

raise "\nПроизошла ошибка при обработке данных #{source}" if collection.nil?

puts "\nФильм какого режиссёра Вы хотите посмотреть?", collection.directors_list

user_select = nil
until ("1".."#{collection.directors.size}").include? user_select
  puts "\nВведите номер, соответствующий режиссёру"
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1
puts "\nРекомендуем посмотреть:"
puts collection.offer_movie(user_select)
