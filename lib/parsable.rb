require 'open-uri'
require 'nokogiri'
module Parsable
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
      library = library.map { |k, v| [k].product(v) }.transpose.map(&:to_h).map { |params| Film.new(params) }
    rescue NoMethodError
      library = []
    end
    library
  end
end
