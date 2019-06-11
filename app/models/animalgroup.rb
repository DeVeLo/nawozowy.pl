# coding: utf-8
class Animalgroup < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :zlecenie
  belongs_to :uzytek
  has_many :animals, dependent: :destroy
  has_many :zwierzeta, through: :animals
  has_many :gatunki, through: :zwierzeta
  has_many :systemyutrzymania, through: :animals
  has_many :nazwyutrzymania, through: :systemyutrzymania
  has_many :nawozynaturalne, dependent: :destroy
  before_save :set_name
  

  # nazwa wyświetlana w tabeli i polu wyboru
  def animalsname
    self.gatunki.distinct.pluck(:name).join(', ') + ' - ' +
      self.nazwyutrzymania.distinct.pluck(:sname).join(', ') +
      if  self.animals.where(zrodlo: true).any?
        " (zakupiony)"
      else
        ""
      end
      
  end

  def srednia_zawartosc
    srednia = 0
    w = 0
    self.animals.each do |z|
      w = z.produkt / produkt
      srednia = srednia + w * z.zawartosc_wynikowa
    end
    srednia
  end
  
  def maksymalna_dawka
    if srednia_zawartosc > 0
      170 / srednia_zawartosc
    else
      0
    end
  end
  
  # produkt całkowity w grupie
  def produkt
    produkt = 0
    self.animals.each do |p|
      produkt += p.produkt
    end
    return produkt
  end

  # pozostały nawóz po zastosowaniu na użytkach
  def pozostalynawoz
    pozostaly = 0
    self.animals.each do |a|
      pozostaly += a.pozostalynawoz
    end
    return pozostaly
  end

  def produkcja_azot
    azot = 0
    self.animals.each do |a|
      azot += a.azot
    end
    return azot
  end

  def pozostaly_azot
    pozostaly = 0
    self.animals.each do |a|
      pozostaly += a.pozostalyazot
    end
    return pozostaly
  end

  def produkcja_fosfor
    fosfor = 0
    self.animals.each do |a|
      fosfor += a.produkcja_fosfor
    end
    return fosfor
  end

  def pozostaly_fosfor
    pozostaly = 0
    self.animals.each do |a|
      pozostaly += a.pozostaly_fosfor
    end
    return pozostaly
  end

  def produkcja_potas
    potas = 0
    self.animals.each do |a|
      potas += a.produkcja_potas
    end
    return potas
  end

  def pozostaly_potas
    pozostaly = 0
    self.animals.each do |a|
      pozostaly += a.pozostaly_potas
    end
    return pozostaly
  end

  
  # ustawia domyślną nazwę grupy
  def set_name
    self.name = "grupa " + (self.zlecenie.animalgroups.count + 1).to_s
  end
  
end
