class Ocenafosfor < ApplicationRecord
  require('csv')
  belongs_to :kategoria
  belongs_to :ocena

  def self.import
    CSV.foreach('ocenafosfor.csv', { col_sep: ';', headers: true }) do |r|
      
      if r[1] == 'min'
        (1..4).each do |k|
          Ocenafosfor.create(ocena_id: r[0].to_i, kategoria_id: k, weglanowa: r[2].to_i, powyzej: r[3].to_i, ponizej: r[4])
        end
      else
        Ocenafosfor.create(ocena_id: r[0].to_i, kategoria_id: 5, weglanowa: r[2].to_i, powyzej: r[3].to_i, ponizej: r[4])
      end
      
    end
    
  end
end
