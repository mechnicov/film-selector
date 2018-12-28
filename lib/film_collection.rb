require 'open-uri'
require 'nokogiri'
require 'json'

class FilmCollection
  JSON_FILE = __dir__ + '/../data/.json'

  attr_reader :directors, :directors_list

  def self.from_plain_text
    library = Dir[__dir__ + '/../data/*.txt'].map { |path| Film.from_plain_text(path) }
    return nil if library.empty?
    self.new(library)
  end

  def self.from_json
    library = JSON.parse(File.read(JSON_FILE), symbolize_names: true).map {|params| Film.new(params)}
    return nil if library.empty?
    self.new(library)
  end

  def self.read_kinopoisk
    url     = 'https://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/200/page/'
    library = { title: [], country: [], year: [], director: [], genre: [],
                duration: [], rating: [], place: [], link: [] }
    pages   = (1..3).to_a

    pages.each do |page|
      html = open(url + "#{page}")
      doc  = Nokogiri::HTML(html)

      library[:title]  += doc.css('div.WidgetStars').map { |div| div.attribute('data-film-title').value }
      library[:rating] += doc.css('div.WidgetStars').map { |div| div.attribute('data-film-rating').value }
      library[:link]   += doc.
        css('div.WidgetStars').
        map { |div| 'https://www.kinopoisk.ru/film/' + div.attribute('data-film-id').value }
      library[:place]  += doc.css("div[class=\"num\srangImp\"]").map(&:text)

      info = doc.css("span[style='color: #888; font-family: arial; font-size: 11px; display: block']").map(&:text)
      library[:year]     += info.map { |info| info.match(/\d{4}/).to_s }
      library[:duration] += info.map { |info| info.match(/\d+ мин\./).to_s }

      info =
        doc.
          css('td.news span.gray_text').
          map(&:content).
          select.with_index { |content, index| index % 3 == 0 }.
          map(&:strip).
          map { |info| info.split("\n") }
      library[:country]  += info.map { |film| film[0].delete('.,') }
      library[:director] += info.map { |film| film[1].strip.gsub('реж. ', '').chomp('...') }
      library[:genre]    += info.map { |film| film[2].strip.delete('().') }
    end

    begin
      @library = library.map { |k, v| [k].product(v) }.transpose.map(&:to_h).map { |params| Film.new(params) }
    rescue NoMethodError
      @library = []
    end
  end

  def self.from_kinopoisk
    self.read_kinopoisk
    return nil if @library.empty?
    self.new(@library)
  end

  def self.update_json
    self.read_kinopoisk
    return nil if @library.empty?
    File.write(JSON_FILE, JSON.pretty_generate(@library.map(&:params)))
  end

  def initialize(library = [])
    @library = library
    @directors = @library.map(&:director).shuffle
    @directors.uniq!
    @directors_list = @directors.map.with_index { |value, index| "#{index + 1}. #{value}" }

    i = 10
    (@directors.size / 10).times do
      @directors_list.insert(i, '')
      i += 11
    end
  end

  def offer_film(user_select)
    @library.select { |film| film.director == @directors[user_select] }.sample
  end
end
