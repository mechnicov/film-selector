require_relative 'lib/film_collection'
require_relative 'lib/film'

source_id = nil
until %w(и л о).include? source_id
  STDOUT.puts "Что Вы хотите?\n" \
              "- подобрать фильм из (И)нтернета\n" \
              "- подобрать фильм из (л)окального хранилища (информация могла устареть)\n" \
              "- (о)бновить локальное хранилище фильмов"
  source_id = STDIN.gets.chomp.downcase
end

STDOUT.puts 'Идёт обработка данных сайта kinopoisk.ru. Ожидайте окончания...' if source_id != 'л'

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

abort "Произошла ошибка при обработке данных #{source}" if collection.nil?
exit if source_id == 'о'

STDOUT.puts 'Фильм какого режиссёра Вы хотите посмотреть?', collection.directors_list

user_select = nil
until ("1".."#{collection.directors.size}").include? user_select
  STDOUT.puts 'Введите номер, соответствующий режиссёру'
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1
STDOUT.puts "\nРекомендуем посмотреть:"
STDOUT.puts collection.offer_film(user_select)
