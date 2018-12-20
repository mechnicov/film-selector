class Film
  attr_reader :id, :title, :director, :year

  def initialize(id, title, director, year)
    @id = id
    @title = title
    @director = director
    @year = year
  end
end