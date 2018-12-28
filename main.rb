require_relative 'lib/film_collection'
require_relative 'lib/film'

source = nil
until %w(и л).include? source
  STDOUT.puts "Откуда Вы хотите получить информацию о фильме?\n" \
              "- из (И)нтернета (актуальная информация)\n" \
              "- из (л)окального хранилища (информация могла устареть)"
  source = STDIN.gets.chomp.downcase
end

if source == 'и'
  STDOUT.puts 'Идёт обработка данных сайта kinopoisk.ru. Ожидайте окончания...'
  collection = FilmCollection.from_kinopoisk
  source = 'с сайта kinopoisk.ru'
else
  collection = FilmCollection.from_local
  source = 'в папке data'
end

abort "Произошла ошибка при обработке данных #{source}" if collection.nil?

STDOUT.puts 'Фильм какого режиссёра Вы хотите посмотреть?', collection.directors_list

user_select = nil
until ("1".."#{collection.directors.size}").include? user_select
  STDOUT.puts 'Введите номер, соответствующий режиссёру'
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1
STDOUT.puts "\nРекомендуем посмотреть:"
STDOUT.puts collection.offer_film(user_select)
