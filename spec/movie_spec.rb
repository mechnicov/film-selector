require 'movie'

RSpec.describe Movie do
  let(:movie_info) {
    %Q(
    «Зеленая миля» (США, 1999) – Фрэнк Дарабонт
    Жанр: фэнтези, драма, криминал
    Продолжительность: 189 мин.
    Рейтинг КиноПоиск: 9.062 (2 место)
    Подробнее: https://www.kinopoisk.ru/film/435/)
  }

  describe '.from_plain_text' do
    let (:movie) { Movie.from_plain_text("#{__dir__}/fixtures/1.txt") }

    it 'should return instance variables' do
      expect(movie.title).to eq 'Зеленая миля'
      expect(movie.country).to eq 'США'
      expect(movie.year).to eq '1999'
      expect(movie.director).to eq 'Фрэнк Дарабонт'
      expect(movie.genre).to eq 'фэнтези, драма, криминал'
      expect(movie.duration).to eq '189 мин.'
      expect(movie.rating).to eq '9.062'
      expect(movie.place).to eq '2'
      expect(movie.link).to eq 'https://www.kinopoisk.ru/film/435/'
      expect(movie.params).to match ( { title: 'Зеленая миля', country: 'США', year: '1999',
                                       director: 'Фрэнк Дарабонт', genre: 'фэнтези, драма, криминал',
                                       duration: '189 мин.', rating: '9.062', place: '2',
                                       link: 'https://www.kinopoisk.ru/film/435/' } )
    end
  end

  describe '#to_s' do
    let (:movie) { Movie.new(title: 'Зеленая миля', country: 'США', year: '1999',
                            director: 'Фрэнк Дарабонт', genre: 'фэнтези, драма, криминал',
                            duration: '189 мин.', rating: '9.062', place: '2',
                            link: 'https://www.kinopoisk.ru/film/435/') }

    it 'should return movie info' do
      expect(movie.to_s).to eq movie_info
    end
  end
end
