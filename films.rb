class Films
  attr_accessor :films_library, :offer
  attr_reader :directors_list

  def initialize(dir_path)
    begin
      files = Dir.entries(dir_path)

      # В папке могут быть другие файлы, например *.avi
      # Кроме того, в ряду 0.txt .. 5.txt может, например, отсутствовать 3.txt
      # Будем считать, что все файлы типа 2.txt и 235.txt содержат-таки фильмы
      films_files = []
      files.each do |value|
        films_files << value if value =~ /^\d+.txt/
      end

      @films_library = []
      films_files.each do |value|
        f = File.new(dir_path + value)
        lines = f.readlines
        f.close
        @films_library << { id:      value.delete(".txt").to_i,
                           title:    lines[0].chomp,
                           director: lines[1].chomp,
                           year:     lines[2].chomp }
      end
    rescue SystemCallError
      @films_library = []
    end
  end

  def set_directors_list
    @directors_list = []

    @films_library.each { |value| @directors_list << value[:director] }

    @directors_list.uniq!
  end

  def print_directors_list
    print_directors_list = []

    @directors_list.each_with_index { |value, index| print_directors_list <<
      "#{index + 1}. #{value}" }

    print_directors_list
  end

  def offer_film(user_choose)
    choosing_films = []
    @films_library.each do |value|
      choosing_films << value if value[:director] == @directors_list[user_choose]
    end
    @offer = choosing_films.sample
  end
end
