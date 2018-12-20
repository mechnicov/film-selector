require_relative 'lib/film_collection.rb'

current_path = File.dirname(__FILE__)
seans = FilmCollection.new(current_path + "/data/")
abort "Сегодня фильмов нет" if seans.films_library.empty?

STDOUT.puts "Фильмы какого режиссера Вы хотите посмотреть?"

seans.set_directors_list

STDOUT.puts seans.print_directors_list

user_choose = nil
until ("1".."#{seans.directors_list.length}").include? user_choose
  STDOUT.puts "Введите цифру, соответствующую режиссёру"
  user_choose = STDIN.gets.chomp
end
user_choose = user_choose.to_i - 1

seans.offer_film(user_choose)

STDOUT.puts "Рекомендуем посмотреть:"
STDOUT.puts "#{seans.offer[:director]} — #{seans.offer[:title]} " \
  "(#{seans.offer[:year]})"
