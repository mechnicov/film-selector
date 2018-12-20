require_relative 'lib/film_collection'
require_relative 'lib/film'

current_path = File.dirname(__FILE__)
collection = FilmCollection.new(current_path + '/data/')
abort 'Сегодня фильмов нет' if collection.library.empty?

STDOUT.puts 'Фильмы какого режиссёра Вы хотите посмотреть?'

STDOUT.puts collection.print_directors_list

user_select = nil
until ("1".."#{collection.directors_list.length}").include? user_select
  STDOUT.puts 'Введите цифру, соответствующую режиссёру'
  user_select = STDIN.gets.chomp
end
user_select = user_select.to_i - 1

STDOUT.puts 'Рекомендуем посмотреть:'
STDOUT.puts collection.offer_film(user_select)
