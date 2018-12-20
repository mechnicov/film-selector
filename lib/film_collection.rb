class FilmCollection
  attr_reader :library, :directors_list

  def initialize(dir_path)
    begin
      # В папке могут быть другие файлы, например *.avi
      # Кроме того, в ряду 0.txt .. 5.txt может, например, отсутствовать 3.txt
      # Будем считать, что все файлы типа 2.txt и 235.txt содержат фильмы
      films_files = Dir.entries(dir_path).select { |value| value =~ /^\d+.txt/ }

      @library = films_files.map do |value|
        f = File.new(dir_path + value)
        lines = f.readlines(chomp: true)
        f.close
        Film.new(value.delete('.txt').to_i, lines[0], lines[1], lines[2])
      end
    rescue SystemCallError
      @library = []
    end

    @directors_list = @library.map { |film| film.director }
    @directors_list.uniq!
  end

  def print_directors_list
    @directors_list.map.with_index { |value, index| "#{index + 1}. #{value}" }
  end

  def offer_film(user_select)
    films_of_selected_director = @library.select { |film| film.director == @directors_list[user_select] }
    offered_film = films_of_selected_director.sample
    "#{offered_film.director} — #{offered_film.title} (#{offered_film.year})"
  end
end
