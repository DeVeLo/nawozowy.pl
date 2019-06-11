# coding: utf-8
class Nawoznaturalny < ApplicationRecord
  belongs_to :uzytek, inverse_of: :nawozynaturalne
  belongs_to :animal
  belongs_to :sezon
  belongs_to :animalgroup
  has_many :nawozywykorzystane, dependent: :destroy

  before_save :oblicz_ilosc
  
  after_create :add_nawozywykorzystane

  validates :animalgroup_id, :uzytek_id, presence: true
  validates :sezon_id, inclusion: { in: [1,2] }

  # nawozy możemy dystrybuować na 3 sposoby
  # 1) ilość t/ha
  # 2) ilość t/pole
  # 3) ilość kg N/ha
  # w zależności od wyboru sposobu
  def oblicz_ilosc
    if self.sposob == 2
      self.ilosc = self.produkcja / self.uzytek.powierzchnia
    elsif self.sposob == 3
      self.ilosc = self.animalgroup.produkt * (self.n / self.animalgroup.produkcja_azot)
    end
  end

  
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

  def wykorzystany_azot
    suma = 0
    self.nawozywykorzystane.each do |nw|
      suma += nw.wykorzystany_azot
    end
    suma
  end

  def wykorzystany_azot_dzialajacy
    suma = 0
    self.nawozywykorzystane.each do |nw|
      suma += nw.wykorzystany_azot_dzialajacy
    end
    suma
  end
  
  def wykorzystany_fosfor
    suma = 0
    self.nawozywykorzystane.each do |nw|
      suma += nw.wykorzystany_fosfor
    end
    suma
  end

  def wykorzystany_potas
    suma = 0
    self.nawozywykorzystane.each do |nw|
      suma += nw.wykorzystany_potas
    end
    suma
  end
  
end
