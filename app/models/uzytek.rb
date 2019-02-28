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
  has_many :nawozynaturalne, inverse_of: :uzytek, dependent: :destroy
  has_many :animalgroups
  has_many :animals, through: :animalgroups
  has_many :nawozywykorzystane, through: :nawozynaturalne

  accepts_nested_attributes_for :nawozynaturalne, allow_destroy: true

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
    podsumowanie = zapotrzebowanie_ha - azot_naturalny_ha
    if podsumowanie > 0
      podsumowanie
    else
      0
    end
  end
  
  # LEWA STRONA
  # zapotrzebowanie na azot na pole
  def zapotrzebowanie
    plon * roslina.pobranie * powierzchnia
  end

  # zapotrzebowanie rośliny w kg N/1 ha
  def zapotrzebowanie_ha
    plon * roslina.pobranie
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
  
  # dodajemy azot z rośliny (przyorana słoma lub korzenie roślin korzeniowych)
  def zroslinaprzedplon
    if roslinaprzedplon_id > 1
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
      nmin * kategoria.przelicznik
      
    # jeśli false to wiosna
    else
      nmin
    end
      
  end

  # wapń
  def cao
    Dawkacao.where(
      kategoria_id: self.kategoria_id,
      grunt_id: self.grunt_id,
    )
      .where('"od" < ?', self.ph)
      .where('"do" >= ?', self.ph).first
  end

  def cao_ha
    unless cao.nil?
      cao.dawka
    else
      nil
    end
  end
  
  def cao_pole
    unless cao.nil?
      cao_ha * powierzchnia
    else
      nil
    end
  end

  # magnez
  def mg_wynik_pole
    unless mg_potrzeby.nil?
      mg_wynik_ha * powierzchnia
    else
      nil
    end
  end
  
  def mg_wynik_ha
    unless mg_rownowaznik.nil? or mg_potrzeby.nil?
      mg_potrzeby + mg_rownowaznik
    else
      nil
    end
  end
  
  def mg_potrzeby
    unless mg_pobranie.nil?
      1.658 * mg_pobranie * self.plon
    else
      nil
    end
  end
  
  def mg_pobranie
    self.roslina.magnez
  end

  def mg_rownowaznik
    unless mg_ocena.nil?
      mg_ocena.rownowaznik
    else
      nil
    end
  end
  
  def mg_ocena
    Ocenamagnez.where(kategoria_id: self.kategoria_id)
      .where('powyzej < ?', self.magnez)
      .where('ponizej >= ?', self.magnez).first
  end
  
end
