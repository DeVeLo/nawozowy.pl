class Zwierze < ApplicationRecord
  require('csv')
  belongs_to :gatunek
  has_many :systemyutrzymania, dependent: :destroy
  has_many :nazwyutrzymania, through: :systemyutrzymania
  has_many :rownowazniki

  def self.export
    file = "#{Rails.root}/zwierzeta.csv"

    zwierzeta = Zwierze.all.order(id: :ASC)

    CSV.open(file, 'w') do |w|
      zwierzeta.each do |z|
        z.nazwyutrzymania.each do |n|
          w << [z.id, z.name, z.gatunek.name, n.id, n.name]
        end
      end
    end
  end

  def self.importuj_rownowazniki
    CSV.foreach('zwierzeta.csv', { col_sep: ',' }) do |r|
      gatunek_id = Zwierze.find(r[0].to_i).gatunek_id
      zwierze_id = Zwierze.find(r[0].to_i).id
      nazwautrzymania_id = r[3].to_i

      Rownowaznik.create(gatunek_id: gatunek_id,
                         zwierze_id: zwierze_id,
                         nazwautrzymania_id: nazwautrzymania_id,
                         sezon_id: 1,
                         jesien: r[5].to_d,
                         wiosna: r[6].to_d,
                         wariant: r[7].to_s)
    end
  end
  
  def self.import
    CSV.foreach('zwierzeta.csv', { col_sep: ';'}) do |r|
      
      gatunek = Gatunek.find_by_name(r[0].to_s.strip)
      nazwa = r[1].to_s.strip
      wspolczynnik = r[2].strip.gsub(/\,/,'.').to_d
      koncentracja_string = r[17]
      if koncentracja_string != '' && ! koncentracja_string.nil?
        koncentracja = koncentracja_string.strip.gsub(/\,/,'.').to_d
      else
        koncentracja = nil
      end
      
      zwierze = Zwierze.create(gatunek: gatunek, name: nazwa, wspolczynnik: wspolczynnik, koncentracja: koncentracja)

      unless r[5].nil?
        gop_string = r[5]
        if gop_string != '' && ! gop_string.nil?
          gop = gop_string.strip.gsub(/\,/,'.').to_d
          goz = r[6].strip.gsub(/\,/,'.').to_d
          gj = r[7].strip.to_i
          zwierze.systemyutrzymania.create(produkcja: gop, zawartosc: goz, jednostkautrzymania_id: gj, nazwautrzymania_id: 1)
        end
      end

      unless r[8].nil?
        pop_string = r[8]
        if pop_string != '' && ! pop_string.nil?
          pop = pop_string.strip.gsub(/\,/,'.').to_d
          poz = r[9].strip.gsub(/\,/,'.').to_d
          poj = r[10].strip.to_i
          zwierze.systemyutrzymania.create(produkcja: pop, zawartosc: poz, jednostkautrzymania_id: poj, nazwautrzymania_id: 2)
        end
      end

      unless r[11].nil?
        pgp_string = r[11]
        if pgp_string != '' && ! pgp_string.nil?
          pgp = pgp_string.strip.gsub(/\,/,'.').to_d
          pgz = r[12].strip.gsub(/\,/,'.').to_d
          pgj = r[13].strip.to_i
          zwierze.systemyutrzymania.create(produkcja: pgp, zawartosc: pgz, jednostkautrzymania_id: pgj, nazwautrzymania_id: 3)
        end
      end

      unless r[14].nil?
        bgp_string = r[14]
        if bgp_string != '' && ! bgp_string.nil?
          bgp = bgp_string.strip.gsub(/\,/,'.').to_d
          bgz = r[15].strip.gsub(/\,/,'.').to_d
          bj = r[16].strip.to_i
          zwierze.systemyutrzymania.create(produkcja: bgp, zawartosc: bgz, jednostkautrzymania_id: bj, nazwautrzymania_id: 4)
        end
      end
      
      puts gatunek.name + ' ' + nazwa + ' ' + wspolczynnik.to_s
      
    end
  end
end
