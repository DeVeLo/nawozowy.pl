class Dawkacao < ApplicationRecord
  require('csv')
  belongs_to :kategoria
  belongs_to :grunt
  belongs_to :potrzeba

  def self.import
    CSV.foreach('wapnowanie.csv', { col_sep: ';', headers: true }) do |r|
      if r[0].to_s.strip != ''
        if r[0] == 'orna'
          (1..3).each do |grunt_id|
            create_dawka(
              grunt_id,
              r[2].to_i,
              if r[3] == '-' then nil else r[3].gsub(/\,/,'.').to_d end,
              if r[4] == '-' then nil else r[4].gsub(/\,/,'.').to_d end,
              if r[5] == '-' then nil else r[5].gsub(/\,/,'.').to_d end,
              r[7].to_i
            )
          end
        else
          create_dawka(
            4,
            r[2].to_i,
            if r[3] == '-' then nil else r[3].gsub(/\,/,'.').to_d end,
            if r[4] == '-' then nil else r[4].gsub(/\,/,'.').to_d end,
            if r[5] == '-' then nil else r[5].gsub(/\,/,'.').to_d end,
            r[7].to_i
          )
        end
      end
    end
  end

  def self.create_dawka(grunt_id, kategoria_id, od, dod, dawka, potrzeba_id)
   Dawkacao.create(
      grunt_id: grunt_id,
      kategoria_id: kategoria_id,
      od: od,
      do: dod,
      dawka: dawka,
      potrzeba_id: potrzeba_id
   )
    puts grunt_id.to_s + ' ' + kategoria_id.to_s + ' ' + od.to_s + ' ' + dod.to_s + ' ' + + potrzeba_id.to_s
  end
  
end
