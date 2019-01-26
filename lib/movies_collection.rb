require 'json'
class MoviesCollection
  attr_reader :directors

  def self.from_plain_text(txt_path)
    library = Dir[txt_path].map { |path| Movie.from_plain_text(path) }
    return nil if library.empty?
    self.new(library)
  end

  def self.from_json(json_file)
    library = JSON.parse(File.read(json_file), symbolize_names: true).
                map { |params| Movie.new(params) }
    return nil if library.empty?
    self.new(library)
  end

  def self.from_kinopoisk
    library = Kinopoisk.parse
    return nil if library.empty?
    self.new(library)
  end

  def initialize(library)
    @library = library
    @directors = @library.map(&:director).uniq
  end

  def directors_list
    list = directors.map.with_index(1) { |value, index| "#{index}. #{value}" }

    i = 10
    (directors.size / 10).times do
      list.insert(i, '')
      i += 11
    end
    list
  end

  def offer_movie(user_select)
    @library.select { |movie| movie.director == directors[user_select] }.sample
  end
end
