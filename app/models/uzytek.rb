# coding: utf-8
class Uzytek < ApplicationRecord
  belongs_to :kategoria
  belongs_to :rodzajuprawy
  belongs_to :roslina
  belongs_to :roslinaprzedplon
  belongs_to :bobowata
  belongs_to :zlecenie
  belongs_to :rolnik
  belongs_to :grunt
  belongs_to :wspwykorzystania
  has_many :animalgroups
  has_many :animals, through: :animalgroups
  has_many :nawozynaturalne, inverse_of: :uzytek, dependent: :destroy
  has_many :nawozywykorzystane, through: :nawozynaturalne

  accepts_nested_attributes_for :nawozynaturalne, allow_destroy: true

  # automagiczna numeracja porządkowa
  after_create :set_lp
  after_create :set_name
  
  # ustal następny nr porządkowy
  def next_lp
    u = Zlecenie.find(self.zlecenie_id).uzytki.where('lp IS NOT NULL').order(lp: :ASC).last
    if u.nil?
      1
    else
      (u.lp  + 1)
    end
  end
  
  # ustaw numer porządkowy do nowego użytku
  def set_lp
    unless self.lp
      self.update(lp: next_lp)
    end
  end

  # jeśli nie podano nazwy użytku
  # ustaw taką samą jak nr porządkowy
  def set_name
    unless self.name
      self.update(name: self.lp)
    end
  end
  
  
  # jeśli gleba organiczna (id == 5)
  # ustaw węglanową na false
  before_save :set_weglanowa
  
  # jeśli gleba organiczna (id == 5)
  # ustaw węglanową na false
  def set_weglanowa
    if self.kategoria_id == 5
      self.weglanowa = false
    end
  end
  
  # PEŁNA SUMA AZOTU DO ZASTOSOWANIA
  def azot_pole
    azot * powierzchnia
  end
  
  def azot
    azot_naturalny_ha + azot_mineralny_ha
  end

  def azot_w_nawozie
      azot_naturalny_ha + azot_mineralny_ha_w_nawozie
  end
  
  # ewentualne saldo N
  def saldo_n
    saldo = zapotrzebowanie_ha - azot_naturalny_ha
    if saldo > 0
      0
    else
      - saldo
    end
  end

  def azot_mineralny_pole_w_nawozie
    (azot_mineralny_ha / 0.7) * powierzchnia
  end  
  
  def azot_mineralny_ha_w_nawozie
    (azot_mineralny_ha / 0.7)
  end

  def azot_mineralny_pole
    azot_mineralny_ha * powierzchnia
  end
  # azot mineralny do zastosowania
  # SUMA AZOTU MINERALNEGO DO ZASTOSOWANIA
  def azot_mineralny_ha
    if self.korekta_azot.nil?
      podsumowanie = zapotrzebowanie_ha - azot_naturalny_ha
      if podsumowanie > 0
        podsumowanie
      else
        0
      end
    else
      self.korekta_azot * 0.7
    end
  end
  
  # LEWA STRONA
  # zapotrzebowanie na azot na pole
  def zapotrzebowanie
    plon * roslina.pobranie * powierzchnia
  end

  # zapotrzebowanie rośliny w kg N/1 ha
  def zapotrzebowanie_ha
    plon * roslina.pobranie + if roslinaprzedplon.id > 2 then roslinaprzedplon.n else 0 end
  end

  # PRAWA STRONA
  # AZOT NATURALNY SUMA ***********************
  # ilość azotu naturalnego per pole
  def azot_naturalny_pole
    azot_naturalny_ha * powierzchnia
  end

  # ilość azotu naturalnego per ha
  def azot_naturalny_ha
    zanimalsami
  end

  # azot z dodatkiem nawozu naturalnego
  def zanimalsami
    (zbobowata + self.nawoznaturalny)
  end

  # ilość działającego nawozu naturalnego / ha
  def nawoznaturalny
    zanimalsami = 0
    self.nawozywykorzystane.each do |nw|
      zanimalsami += (nw.ilosc * nw.animal.zawartosc_wynikowa * nw.animal.getrownowaznik(nw.nawoznaturalny.sezon_id))
    end
    zanimalsami
  end

  # ilosc zastosowanego nawozu naturalnego / ha
  def nawoznaturalnyzastosowany
    zanimalsami = 0
    self.nawozywykorzystane.each do |nw|
      zanimalsami += (nw.ilosc * nw.animal.zawartosc_wynikowa)
    end
    zanimalsami
  end
  
  
  # z dodatkiem bobowatych
  def zbobowata
    if bobowata_id > 1
      zroslinaprzedplon + bobowata.n
    else
      zroslinaprzedplon
    end
  end
  
  # dodajemy azot z rośliny dla korzenie roślin korzeniowych
  def zroslinaprzedplon
    if roslinaprzedplon_id == 2
      zprzedplonem + roslinaprzedplon.n
    else
      zprzedplonem
    end
  end

  # nazwa rośliny na przedplon
  def nazwaroslinaprzedplon
    roslinaprzedplon.name
  end
  
  # azot w glebie po zastosowaniu przedplonu
  def zprzedplonem
    jaraozima + realnyprzedplon
  end
  
  # realny azot z przedplonu jest wynikiem mnożenia przez 0.15
  def realnyprzedplon
    przedplon * 0.15
  end
  
  # zasobność mnożymy przez współczynnik
  # zależnie czy roślina jara czy ozima
  def jaraozima
    gleba * roslina.wspolczynnik
  end

  # współczynnik rośliny jara / ozima
  def wspolczynnikrosliny
    roslina.wspolczynnik
  end

  # nazwa roślinki
  def nazwarosliny
    roslina.rodzajuprawy.name + ': ' + roslina.name
  end

  # nazwa bobowatej
  def nazwabobowata
    bobowata.name
  end
  
  # zasobność gleby w azot mineralny
  def gleba
    if badania
      nmin_sezon
    else
      zasobsezon
    end
  end

  def zasobsezon
    # jeśli true to jesień i trzeba przeliczyć na podstawie przelicznika
    # zależnego od kategorii gleby
    if nminsezon
      kategoria.zasob * przelicznik
      
    # jeśli false to wiosna
    else
      kategoria.zasob
    end
  end

    
  # przelicznik jeżeli na podstawie badania
  # przeprowadzonego jesienią
  def przelicznik
    kategoria.przelicznik
  end

  # nmin z uwzględnieniem sezonu
  def nmin_sezon
    
    # jeśli true to jesień i trzeba przeliczyć na podstawie przelicznika
    # zależnego od kategorii gleby
    if nminsezon
      nmin * przelicznik
      
    # jeśli false to wiosna
    else
      nmin
    end
      
  end

  # wapń
  def cao
    Dawkacao.where(
      kategoria_id: kategoria_id,
      grunt_id: grunt_id,
      sad: roslina.sad,
    )
      .where('"od" < ?', ph)
      .where('"do" >= ?', ph).first
  end

  def cao_ha
    if self.korekta_wapn.nil?
      unless cao.nil?
        cao.dawka
      else
        nil
      end
    else
      self.korekta_wapn
    end
  end
  
  def cao_pole
    unless cao_ha.nil?
      cao_ha * powierzchnia
    else
      0
    end
  end

  # wynik - magnez / ha
  def mg_wynik_ha
    Uzytek::Magnez.new(self).wynik
  end
    
  # wynik - magnez / pole
  def mg_wynik_pole
    Uzytek::Magnez.new(self).wynik_pole
  end
    
  def wynik_fosfor
    if korekta_fosfor.nil?
      Uzytek::Fosfor.new(self).wynik
    else
      self.korekta_fosfor
    end
  end

  def wynik_potas
    if korekta_potas.nil?
      Uzytek::Potas.new(self).wynik
    else
      self.korekta_potas
    end
  end


  def fosfor_wynik_pole
    unless self.wynik_fosfor.nil?
      (self.wynik_fosfor * self.powierzchnia).round.to_s
    else
      '0'
    end
  end

  def fosfor_ocena_slowna
    Uzytek::Fosfor.new(self).ocena_slowna
  end
  
  def potas_wynik_pole
    unless self.wynik_potas.nil?
      (self.wynik_potas * self.powierzchnia).round.to_s
    else
      '0'
    end
  end

  def mg_pole
    unless self.mg_wynik_ha.nil?
      self.mg_wynik_pole.round.to_s
    else
      '0'
    end
  end

end
