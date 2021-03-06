# coding: utf-8
class Zlecenie < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :wariant
  belongs_to :podstawa
  belongs_to :gmina
  belongs_to :powiat
  belongs_to :wojewodztwo

  has_many :animalgroups, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :uzytki, dependent: :destroy
  has_many :nawozynaturalne, through: :uzytki
  has_many :nawozywykorzystane, through: :animals
  
  # automagiczna numeracja porządkowa
  after_create :set_lp
  after_create :set_rejestr

  # powiela zlecenie wraz z zawartością i ustawia je jako kolejny rok gospodarczy
  def powiel
    zlecenie = self.dup
    zlecenie.name = (self.name[0,4].to_i + 1).to_s + '/' + (self.name[0,4].to_i + 2).to_s
    zlecenie.datawplywu = Date.today
    zlecenie.parent_id = self.id
    zlecenie.rejestr = nil
    zlecenie.datawydruku = Date.today
    zlecenie.save

    self.uzytki.each do |uzytek|
      u = uzytek.dup
      u.zlecenie = zlecenie
      u.save
    end
    
    # powila grupy z poprzedniego zlecenia
    self.animalgroups.each do |animalgroup|
      a = animalgroup.dup
      a.zlecenie = zlecenie
      a.save
      animalgroup.animals.each do |animal|
        an = animal.dup
        an.zlecenie = zlecenie
        an.animalgroup = a
        an.save
      end
    end

    # zlecenie.rolnik.update(updated_at: Time.now)
    zlecenie
  end
  
  def nr_zlecenia
    rejestr.to_s + "/" + (typ ? "PP" : "PA") + "/" + datawplywu.year.to_s
  end
  
  # ustal następny nr porządkowy
  def next_lp
    z = Rolnik.find(self.rolnik_id).zlecenia.where('lp IS NOT NULL').order(lp: :ASC).last

    if z.nil?
      1
    else
      (z.lp  + 1)
    end
  end
  
  # ustaw numer porządkowy do nowego zlecenia
  def set_lp
    unless self.lp
      self.update(lp: next_lp)
    end
  end

  # ustal kolejny numer w rejestrze
  # maska rejestru:
  # rejestr/PA lub PP/rok (np. 4/PP/2019)
  def next_rejestr
    z = Zlecenie.where('rejestr IS NOT NULL')
          .where(datawplywu: self.datawplywu.beginning_of_year..self.datawplywu.end_of_year)
          .where(instytucja_id: self.instytucja_id)
          .order(rejestr: :ASC)
          .last
    if z.nil?
      1
    else
      (z.rejestr  + 1)
    end
  end

  # ustaw numer rejestru w tym roku
  def set_rejestr
    unless self.rejestr
      self.update(rejestr: next_rejestr)
    end
    self.rolnik.update(updated_at: Time.now)
  end

  # dane dotyczące nawozu naturalnego #############
  def produkcja_obornika
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_obornika.round(2)
  end

  alias produkcja_obornik produkcja_obornika
  
  def produkcja_gnojowki
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_gnojowki.round(2)
  end

  alias produkcja_gnojowka produkcja_gnojowki
  
  def produkcja_gnojowicy
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_gnojowicy.round(2)
  end

  alias produkcja_gnojowica produkcja_gnojowicy

  def zakupiony_obornik
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiony_obornik.round(2)
  end

  def zakupiona_gnojowka
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiona_gnojowka.round(2)
  end

  def zakupiona_gnojowica
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiona_gnojowica.round(2)
  end
  
  def produkcja_obornika_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_obornika_azot.round(2)
  end

  alias  produkcja_obornik_azot produkcja_obornika_azot

  def produkcja_gnojowki_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_gnojowki_azot.round(2)
  end

  alias produkcja_gnojowka_azot produkcja_gnojowki_azot

  def produkcja_gnojowicy_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja_gnojowicy_azot.round(2)
  end

  alias produkcja_gnojowica_azot produkcja_gnojowicy_azot

  def zakupiony_obornik_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiony_obornik_azot.round(2)
  end

  def zakupiona_gnojowka_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiona_gnojowka_azot.round(2)
  end

  def zakupiona_gnojowica_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.zakupiona_gnojowica_azot.round(2)
  end
  
  def pozostaly_obornik
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostaly_obornik.round(2)
  end

  def pozostala_gnojowka
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostala_gnojowka.round(2)
  end

  def pozostala_gnojowica
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostala_gnojowica.round(2)
  end

  def pozostaly_obornik_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostaly_obornik_azot.round(2)
  end

  def pozostala_gnojowka_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostala_gnojowka_azot.round(2)
  end

  def pozostala_gnojowica_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostala_gnojowica_azot.round(2)
  end

  def zastosowany_obornik
    zakupiony_obornik + produkcja_obornika - pozostaly_obornik
  end

  def zastosowana_gnojowka
    zakupiona_gnojowka + produkcja_gnojowki - pozostala_gnojowka
  end

  def zastosowana_gnojowica
    zakupiona_gnojowica + produkcja_gnojowicy - pozostala_gnojowica
  end

  def zastosowany_obornik_azot
    zakupiony_obornik_azot + produkcja_obornika_azot - pozostaly_obornik_azot
  end

  def zastosowana_gnojowka_azot
    zakupiona_gnojowka_azot + produkcja_gnojowki_azot - pozostala_gnojowka_azot
  end

  def zastosowana_gnojowica_azot
    zakupiona_gnojowica_azot + produkcja_gnojowicy_azot - pozostala_gnojowica_azot
  end

  def zastosowany_obornik_azot_dzialajacy
    zastosowany_obornik_azot * 0.7
  end

  def zastosowana_gnojowka_azot_dzialajacy
    zastosowana_gnojowka_azot * 0.7
  end

  def zastosowana_gnojowica_azot_dzialajacy
    zastosowana_gnojowica_azot * 0.7
  end
  
  def produkcja_nawozu
    zn = Zlecenie::Nawoz.new(self)
    zn.produkcja.round(2)
  end

  def pozostaly_nawoz
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostala_nawoz.round(2)
  end

  def produkcja_azotu
    zn = Zlecenie::Nawoz.new(self)
    zn.azot.round(2)
  end

  def pozostaly_azot
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostaly_azot.round(2)
  end

  def produkcja_fosforu
    zn = Zlecenie::Nawoz.new(self)
    zn.fosfor.round(2)
  end

  def pozostaly_fosfor
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostaly_fosfor.round(2)
  end

  def produkcja_potasu
    zn = Zlecenie::Nawoz.new(self)
    zn.potas.round(2)
  end

  def pozostaly_potas
    zn = Zlecenie::Nawoz.new(self)
    zn.pozostaly_potas.round(2)
  end

  # dane do wydruku głównego
  def liczba_roslino_dzialek
    uzytki.count
  end

  def suma_powierzchni_uzytkow
    uzytki.sum(:powierzchnia)
  end

  def powierzchnia_gruntow_ornych
    uzytki.where(grunt_id: 1).sum(:powierzchnia)
  end

  def powierzchnia_uzytkow_zielonych
    uzytki.where(grunt_id: 4).sum(:powierzchnia)
  end

  def powierzchnia_uzytkow_wieloletnich
    uzytki.where(grunt_id: [2,3]).sum(:powierzchnia)
  end

  def ilosc_nawozow_zastosowanych
    produkcja_nawozu - pozostaly_nawoz
  end

  def ilosc_azotu_zastosowanego
    produkcja_azotu - pozostaly_azot
  end

  def ilosc_azotu_dzialajacego
    ilosc_azotu_zastosowanego * 0.7
  end

  def sredni_bilans
    suma = 0
    uzytki.each do |u|
      suma += u.saldo_n
    end
    
    if uzytki.count > 0
      suma / uzytki.count
    else
      0
    end
  end

  def azot_razem
    suma = 0
    self.uzytki.each do |u|
      suma += (u.azot_mineralny_pole_w_nawozie.nil?)?0:u.azot_mineralny_pole_w_nawozie.round
    end
    suma
  end

  def fosfor_razem
    suma = 0
    self.uzytki.each do |u|
      suma += (u.wynik_fosfor.nil?)?0:(u.wynik_fosfor * u.powierzchnia).round
    end
    suma
  end

  def potas_razem
    suma = 0
    self.uzytki.each do |u|
      suma += (u.wynik_potas.nil?)?0:(u.wynik_potas * u.powierzchnia).round
    end
    suma
  end

  def magnez_razem
    suma = 0
    self.uzytki.each do |u|
      suma += (u.mg_wynik_pole.nil?)?0:u.mg_wynik_pole.round
    end
    suma
  end
  
  def cao_razem
    suma = 0
    self.uzytki.each do |u|
      suma += (u.cao_pole.nil?)?0:u.cao_pole.round(2)
    end
    suma
  end
  
end
