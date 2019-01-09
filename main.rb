require_relative 'lib/kinopoisk'
require_relative 'lib/film_collection'
require_relative 'lib/film'

user_key = nil
until %w(и л).include? user_key
  STDOUT.puts "# Подобрать фильм из:\n" \
              "   - (И)нтернета\n" \
              "   - (л)окального списка (информация могла устареть)"
  user_key = STDIN.gets.chomp.downcase
end

if user_key == 'и'
  STDOUT.puts "\nИдёт обработка данных сайта kinopoisk.ru. Ожидайте окончания..."
  collection, source = FilmCollection.from_kinopoisk, 'с сайта kinopoisk.ru'
else
  collection, source = FilmCollection.from_json("#{__dir__}/data/.json"), 'в папке data'
end

abort "\nПроизошла ошибка при обработке данных #{source}" if collection.nil?

STDOUT.puts "\nФильм какого режиссёра Вы хотите посмотреть?", collection.directors_list

user_select = nil
until ("1".."#{collection.directors.size}").include? user_select
  STDOUT.puts "\nВведите номер, соответствующий режиссёру"
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1
STDOUT.puts "\nРекомендуем посмотреть:"
STDOUT.puts collection.offer_film(user_select)
