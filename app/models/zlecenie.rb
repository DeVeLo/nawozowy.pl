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

  after_create :set_lp
  
  def set_lp
    unless self.lp
      self.update(lp: self.rolnik.zlecenia.count)
    end
  end
end
