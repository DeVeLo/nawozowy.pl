class Ocenamagnez < ApplicationRecord
  require('csv')
  belongs_to :ocena
  belongs_to :kategoria

  def self.import
    CSV.foreach('ocenamagnezsady.csv', { col_sep: ';', headers: true }) do |r|
      
      Ocenamagnez.create(ocena_id: r[1].to_i, kategoria_id: r[2].to_i, powyzej: r[4].to_d, ponizej: r[5].to_d, sad: true)
      
    end
    
  end
end
