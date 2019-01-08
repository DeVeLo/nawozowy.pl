class Rodzajuprawy < ApplicationRecord
  require('csv')
  has_many :rosliny

  def self.import
    CSV.foreach('rodzajeupraw.csv', { col_sep: ';'}) do |r|
      Rodzajuprawy.create(name: r[0].strip)
    end
  end
end
