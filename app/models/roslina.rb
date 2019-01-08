class Roslina < ApplicationRecord
  require('csv')
  belongs_to :rodzajuprawy

  def self.import
    CSV.foreach('rosliny.csv', { col_sep: ';'}) do |r|
      rodzaj = Rodzajuprawy.find_by_name(r[0].strip)
      pobranie = r[2].strip.gsub(/\,/,'.').to_d.to_s
      nazwa = r[1].strip
      Roslina.create(name: nazwa, pobranie: pobranie, rodzajuprawy_id: rodzaj.id)
    end
  end
end
