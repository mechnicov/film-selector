class Movie
  attr_reader :title, :country, :year, :director, :genre, :duration,
              :rating, :place, :link, :params

  def self.from_plain_text(path)
    lines = File.readlines(path, chomp: true)
    self.new(title:    lines[0],
             country:  lines[1],
             year:     lines[2],
             director: lines[3],
             genre:    lines[4],
             duration: lines[5],
             rating:   lines[6],
             place:    lines[7],
             link:     lines[8])
  end

  def initialize(params)
    @title    = params[:title]
    @country  = params[:country]
    @year     = params[:year]
    @director = params[:director]
    @genre    = params[:genre]
    @duration = params[:duration]
    @rating   = params[:rating]
    @place    = params[:place]
    @link     = params[:link]
    @params   = params
  end

  def to_s
    %Q(
    «#{title}» (#{country}, #{year}) – #{director}
    Жанр: #{genre}
    Продолжительность: #{duration}
    Рейтинг КиноПоиск: #{rating} (#{place} место)
    Подробнее: #{link})
  end
end
