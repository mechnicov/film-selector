require_relative 'lib/parsable'
require_relative 'lib/film_collection'
require_relative 'lib/film'

source_id = nil
until %w(и л о).include? source_id
  STDOUT.puts "Что Вы хотите?\n\n" \
              "# Подобрать фильм из:\n" \
              "   - (И)нтернета\n" \
              "   - (л)окального списка (информация могла устареть)\n\n" \
              "# (О)бновить локальный список"
  source_id = STDIN.gets.chomp.downcase
end

STDOUT.puts "\nИдёт обработка данных сайта kinopoisk.ru. Ожидайте окончания..." if source_id != 'л'

collection = case source_id
             when 'и' then FilmCollection.from_kinopoisk
             when 'л' then FilmCollection.from_json
             else FilmCollection.update_json
             end

source = if source_id == 'л'
           'в папке data'
         else
           'с сайта kinopoisk.ru'
         end

abort "\nПроизошла ошибка при обработке данных #{source}" if collection.nil?
if source_id == 'о'
  STDOUT.puts "\nЛокальный список фильмов успешно актуализирован в соответствии с рейтингом ТОП500 КиноПоиск"
  exit
end

STDOUT.puts "\nФильм какого режиссёра Вы хотите посмотреть?", collection.directors_list

user_select = nil
until ("1".."#{collection.directors.size}").include? user_select
  STDOUT.puts "\nВведите номер, соответствующий режиссёру"
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1
STDOUT.puts "\nРекомендуем посмотреть:"
STDOUT.puts collection.offer_film(user_select)
