require_relative 'lib/film_collection.rb'

current_path = File.dirname(__FILE__)
collection = FilmCollection.new(current_path + '/data/')
abort 'Сегодня фильмов нет' if collection.library.empty?

STDOUT.puts 'Фильмы какого режиссера Вы хотите посмотреть?'

collection.set_directors_list

STDOUT.puts collection.print_directors_list

user_choose = nil
until ("1".."#{collection.directors_list.length}").include? user_choose
  STDOUT.puts 'Введите цифру, соответствующую режиссёру'
  user_choose = STDIN.gets.chomp
end
user_choose = user_choose.to_i - 1

collection.offer_film(user_choose)

STDOUT.puts 'Рекомендуем посмотреть:'
STDOUT.puts "#{collection.offer[:director]} — #{collection.offer[:title]} " \
  "(#{collection.offer[:year]})"
