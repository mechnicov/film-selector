require 'film_collection'
require 'kinopoisk'

describe FilmCollection do
  let (:library) { collection.instance_variable_get(:@library) }

  describe '.new' do
    let (:collection) { FilmCollection.new([Film.new( { :title => 'Побег из Шоушенка',
                                                        :country => 'США',
                                                        :year => '1994',
                                                        :director => 'Фрэнк Дарабонт',
                                                        :genre => 'драма',
                                                        :duration => '142 мин.',
                                                        :rating => '9.112',
                                                        :place => '1',
                                                        :link => 'https://www.kinopoisk.ru/film/326/' } ),
                                            Film.new( { :title => 'Зеленая миля',
                                                        :country => 'США',
                                                        :year => '1999',
                                                        :director => 'Фрэнк Дарабонт',
                                                        :genre => 'фэнтези, драма, криминал',
                                                        :duration => '189 мин.',
                                                        :rating => '9.062',
                                                        :place => '2',
                                                        :link => 'https://www.kinopoisk.ru/film/435/' } ),
                                            Film.new( { :title => 'Форрест Гамп',
                                                        :country => 'США',
                                                        :year => '1994',
                                                        :director => 'Роберт Земекис',
                                                        :genre => 'драма, мелодрама',
                                                        :duration => '142 мин.',
                                                        :rating => '8.916',
                                                        :place => '3',
                                                        :link => 'https://www.kinopoisk.ru/film/448/' } )]) }
    it 'should make collection' do
      expect(library.map(&:title)).to match_array ['Побег из Шоушенка', 'Зеленая миля', 'Форрест Гамп']
    end
  end

  describe '.from_plain_text' do
    let (:collection) { FilmCollection.from_plain_text("#{__dir__}/fixtures/*.txt") }

    it 'should make collection' do
      expect(library.map(&:title)).to match_array ['Побег из Шоушенка', 'Зеленая миля', 'Форрест Гамп']
    end
  end

  describe '.from_json' do
    let (:collection) { FilmCollection.from_json("#{__dir__}/fixtures/test.json") }

    it 'should make collection with right attributes' do
      expect(library.map(&:title)).to match_array ['Побег из Шоушенка', 'Зеленая миля', 'Форрест Гамп']
      expect(library.map(&:country)).to match_array ['США', 'США', 'США']
      expect(library.map(&:year)).to match_array ['1994', '1999', '1994']
      expect(library.map(&:director)).to match_array ['Фрэнк Дарабонт', 'Фрэнк Дарабонт', 'Роберт Земекис']
      expect(library.map(&:genre)).to match_array ['драма', 'фэнтези, драма, криминал', 'драма, мелодрама']
      expect(library.map(&:duration)).to match_array ['142 мин.', '189 мин.', '142 мин.']
      expect(library.map(&:rating)).to match_array ['9.112', '9.062', '8.916']
      expect(library.map(&:place)).to match_array ['1', '2', '3']
      expect(library.map(&:link)).to match_array ['https://www.kinopoisk.ru/film/326/',
                                                  'https://www.kinopoisk.ru/film/435/',
                                                  'https://www.kinopoisk.ru/film/448/']
    end
  end

  describe '.from_kinopoisk' do
    let (:collection) { FilmCollection.from_kinopoisk }

    it 'should make collection' do
      allow(Kinopoisk).to receive(:parse).and_return [Film.new( { :title => 'Побег из Шоушенка',
                                                                  :country => 'США',
                                                                  :year => '1994',
                                                                  :director => 'Фрэнк Дарабонт',
                                                                  :genre => 'драма',
                                                                  :duration => '142 мин.',
                                                                  :rating => '9.112',
                                                                  :place => '1',
                                                                  :link => 'https://www.kinopoisk.ru/film/326/' } ),
                                                      Film.new( { :title => 'Зеленая миля',
                                                                  :country => 'США',
                                                                  :year => '1999',
                                                                  :director => 'Фрэнк Дарабонт',
                                                                  :genre => 'фэнтези, драма, криминал',
                                                                  :duration => '189 мин.',
                                                                  :rating => '9.062',
                                                                  :place => '2',
                                                                  :link => 'https://www.kinopoisk.ru/film/435/' } ),
                                                      Film.new( { :title => 'Форрест Гамп',
                                                                  :country => 'США',
                                                                  :year => '1994',
                                                                  :director => 'Роберт Земекис',
                                                                  :genre => 'драма, мелодрама',
                                                                  :duration => '142 мин.',
                                                                  :rating => '8.916',
                                                                  :place => '3',
                                                                  :link => 'https://www.kinopoisk.ru/film/448/' } )]

      expect(library.map(&:title)).to match_array ['Побег из Шоушенка', 'Зеленая миля', 'Форрест Гамп']
    end
  end

  describe '#directors' do
    let (:collection) { FilmCollection.new([Film.new( { :title => 'Побег из Шоушенка',
                                                        :country => 'США',
                                                        :year => '1994',
                                                        :director => 'Фрэнк Дарабонт',
                                                        :genre => 'драма',
                                                        :duration => '142 мин.',
                                                        :rating => '9.112',
                                                        :place => '1',
                                                        :link => 'https://www.kinopoisk.ru/film/326/' } ),
                                            Film.new( { :title => 'Зеленая миля',
                                                        :country => 'США',
                                                        :year => '1999',
                                                        :director => 'Фрэнк Дарабонт',
                                                        :genre => 'фэнтези, драма, криминал',
                                                        :duration => '189 мин.',
                                                        :rating => '9.062',
                                                        :place => '2',
                                                        :link => 'https://www.kinopoisk.ru/film/435/' } ),
                                            Film.new( { :title => 'Форрест Гамп',
                                                        :country => 'США',
                                                        :year => '1994',
                                                        :director => 'Роберт Земекис',
                                                        :genre => 'драма, мелодрама',
                                                        :duration => '142 мин.',
                                                        :rating => '8.916',
                                                        :place => '3',
                                                        :link => 'https://www.kinopoisk.ru/film/448/' } )]) }

    it 'should return instance variable' do
      expect(collection.directors).to match_array ['Фрэнк Дарабонт', 'Роберт Земекис']
    end
  end

  describe '#offer_film(user_select)' do
    let (:collection) { FilmCollection.new([Film.new( { :title => 'Побег из Шоушенка', :country => 'США',
                                                        :year => '1994', :director => 'Фрэнк Дарабонт',
                                                        :genre => 'драма', :duration => '142 мин.',
                                                        :rating => '9.112', :place => '1',
                                                        :link => 'https://www.kinopoisk.ru/film/326/' } ),
                                            Film.new( { :title => 'Зеленая миля', :country => 'США',
                                                        :year => '1999', :director => 'Фрэнк Дарабонт',
                                                        :genre => 'фэнтези, драма, криминал', :duration => '189 мин.',
                                                        :rating => '9.062', :place => '2',
                                                        :link => 'https://www.kinopoisk.ru/film/435/' } ),
                                            Film.new( { :title => 'Форрест Гамп', :country => 'США',
                                                        :year => '1994', :director => 'Роберт Земекис',
                                                        :genre => 'драма, мелодрама', :duration => '142 мин.',
                                                        :rating => '8.916', :place => '3',
                                                        :link => 'https://www.kinopoisk.ru/film/448/' } )]) }

    it 'should offer film of selected director' do
      expect(collection.offer_film(1).title).to eq 'Форрест Гамп'
    end
  end
end
