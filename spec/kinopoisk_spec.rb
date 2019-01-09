require 'kinopoisk'

describe Kinopoisk do
  describe '.parse' do
    it 'should parse' do
      files = (1..2).map { |i| File.open("#{__dir__}/fixtures/kinopoisk/#{i}.html") }
      allow(Kinopoisk).to receive(:open_request).and_return *files

      library = Kinopoisk.parse
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
end
