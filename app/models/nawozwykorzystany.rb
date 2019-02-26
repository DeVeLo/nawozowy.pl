class Nawozwykorzystany < ApplicationRecord
  belongs_to :animal
  belongs_to :nawoznaturalny

  def ilosc_na_pole
    self.ilosc * self.nawoznaturalny.uzytek.powierzchnia
  end
end
