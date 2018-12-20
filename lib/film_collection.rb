class FilmCollection
  attr_accessor :library, :offer
  attr_reader :directors_list

  def initialize(dir_path)
    begin
      # В папке могут быть другие файлы, например *.avi
      # Кроме того, в ряду 0.txt .. 5.txt может, например, отсутствовать 3.txt
      # Будем считать, что все файлы типа 2.txt и 235.txt содержат-таки фильмы
      films_files = Dir.entries(dir_path).select { |value| value =~ /^\d+.txt/ }

      @library = films_files.map do |value|
        f = File.new(dir_path + value)
        lines = f.readlines
        f.close
        { id:       value.delete('.txt').to_i,
          title:    lines[0].chomp,
          director: lines[1].chomp,
          year:     lines[2].chomp }
      end
      puts @library
    rescue SystemCallError
      @library = []
    end
  end

  def set_directors_list
    @directors_list = @library.map { |value| value[:director] }

    @directors_list.uniq!
  end

  def print_directors_list
    @directors_list.map.with_index { |value, index| "#{index + 1}. #{value}" }
  end

  def offer_film(user_choose)
    choosing_films = @library.select { |value| value[:director] == @directors_list[user_choose] }
    @offer = choosing_films.sample
  end
end
