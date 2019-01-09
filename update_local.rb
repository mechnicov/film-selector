require_relative 'lib/film'
require_relative 'lib/kinopoisk'
require 'json'

STDOUT.puts "\nИдёт обработка данных сайта kinopoisk.ru. Ожидайте окончания..."

library = Kinopoisk.parse
abort "\nПроизошла ошибка при обработке данных с сайта" if library.empty?
File.write("#{__dir__}/data/.json", JSON.pretty_generate(library.map(&:params)))

STDOUT.puts "\nЛокальный список фильмов успешно актуализирован в соответствии с рейтингом ТОП-500 КиноПоиск"
