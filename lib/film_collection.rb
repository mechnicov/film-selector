require 'json'
class FilmCollection
  JSON_FILE = __dir__ + '/../data/.json'
  TXT_PATH  = __dir__ + '/../data/*.txt'
  attr_reader :directors

  def self.from_plain_text
    library = Dir[TXT_PATH].map { |path| Film.from_plain_text(path) }
    return nil if library.empty?
    self.new(library)
  end

  def self.from_json
    library = JSON.parse(File.read(JSON_FILE), symbolize_names: true).map {|params| Film.new(params)}
    return nil if library.empty?
    self.new(library)
  end

  def self.from_kinopoisk
    library = Parsable.read_kinopoisk
    return nil if library.empty?
    self.new(library)
  end

  def self.update_json
    library = Parsable.read_kinopoisk
    return nil if library.empty?
    File.write(JSON_FILE, JSON.pretty_generate(library.map(&:params)))
  end

  def initialize(library)
    @library = library
    @directors = @library.map(&:director).uniq.shuffle
  end

  def directors_list
    list = directors.map.with_index { |value, index| "#{index + 1}. #{value}" }

    i = 10
    (directors.size / 10).times do
      list.insert(i, '')
      i += 11
    end
    list
  end

  def offer_film(user_select)
    @library.select { |film| film.director == directors[user_select] }.sample
  end
end
