# coding: utf-8
class Nawoznaturalny < ApplicationRecord
  belongs_to :uzytek, inverse_of: :nawozynaturalne
  belongs_to :animal
  belongs_to :sezon
  belongs_to :animalgroup
  has_many :nawozywykorzystane, dependent: :destroy
  after_create :add_nawozywykorzystane

  validates :ilosc, :animalgroup_id, :uzytek_id, presence: true
  validates :sezon_id, inclusion: { in: [1,2] }
  
  # musimy dodać wykorzystane ilości
  # nawozu naturalnego dla każdego zwierzęcia
  # dla ułatwienia dalszych obliczeń
  def add_nawozywykorzystane
    produkt = 0
    self.animalgroup.animals.each do |animal|
      produkt += animal.produkt
    end

    self.animalgroup.animals.each do |animal|
      wspolczynnik = animal.produkt / produkt
      ilosc = (self.ilosc * wspolczynnik)
      ilosc_na_pole = (self.ilosc * wspolczynnik) * self.uzytek.powierzchnia
      self.nawozywykorzystane.create({animal_id: animal.id, ilosc: ilosc, ilosc_na_pole: ilosc_na_pole})
    end
  end    
  
end
