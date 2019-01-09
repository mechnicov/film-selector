require 'film'

describe Film do
  describe '.from_plain_text' do
    let (:film) { Film.from_plain_text("#{__dir__}/fixtures/1.txt") }

    it 'should return instance variables' do
      expect(film.title).to eq 'Зеленая миля'
      expect(film.country).to eq 'США'
      expect(film.year).to eq '1999'
      expect(film.director).to eq 'Фрэнк Дарабонт'
      expect(film.genre).to eq 'фэнтези, драма, криминал'
      expect(film.duration).to eq '189 мин.'
      expect(film.rating).to eq '9.062'
      expect(film.place).to eq '2'
      expect(film.link).to eq 'https://www.kinopoisk.ru/film/435/'
      expect(film.params).to match ( { :title => 'Зеленая миля', :country => 'США', :year => '1999',
                                       :director => 'Фрэнк Дарабонт', :genre => 'фэнтези, драма, криминал',
                                       :duration => '189 мин.', :rating => '9.062', :place => '2',
                                       :link => 'https://www.kinopoisk.ru/film/435/' } )
    end
  end

  describe '#to_s' do
    let (:film) { Film.new( { :title => 'Зеленая миля', :country => 'США', :year => '1999',
                              :director => 'Фрэнк Дарабонт', :genre => 'фэнтези, драма, криминал',
                              :duration => '189 мин.', :rating => '9.062', :place => '2',
                              :link => 'https://www.kinopoisk.ru/film/435/' } ) }

    it 'should put film info' do
      expect(film.to_s).to eq "«Зеленая миля» (США, 1999) – Фрэнк Дарабонт\n" \
                              "Жанр: фэнтези, драма, криминал\n" \
                              "Продолжительность: 189 мин.\n" \
                              "Рейтинг КиноПоиск: 9.062 (2 место) \n" \
                              "Подробнее: https://www.kinopoisk.ru/film/435/"
    end
  end
end
