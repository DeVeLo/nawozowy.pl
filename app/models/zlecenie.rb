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
  
  # automagiczna numeracja porządkowa
  after_create :set_lp
  after_create :set_rejestr
  
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
  end

  # dane dotyczące nawozu naturalnego #############
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
  
  
end
