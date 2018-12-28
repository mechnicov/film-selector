class Film
  attr_reader :title, :country, :year, :director, :genre, :duration, :rating, :place, :link

  def self.from_file(path)
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
  end

  def to_s
    "«#{title}» (#{country}, #{year}) – #{director}\n" \
    "Жанр: #{genre}\n" \
    "Продолжительность: #{duration}\n" \
    "Рейтинг КиноПоиск: #{rating} (#{place} место) \n" \
    "Подробнее: #{link}"
  end
end
