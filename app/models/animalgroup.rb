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
    # self.zwierzeta.pluck(:name).join(', ') + ' (' + self.pozostalynawoz.to_s + ' t)'
    self.gatunki.distinct.pluck(:name).join(', ') + ' - ' +
      self.nazwyutrzymania.distinct.pluck(:name).join(', ')
  end

  # produkt całkowityw grupie
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

  # ustawia domyślną nazwę grupy
  def set_name
    self.name = "grupa " + (self.zlecenie.animalgroups.count + 1).to_s
  end
  
end
