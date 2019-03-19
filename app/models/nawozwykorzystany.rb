class Nawozwykorzystany < ApplicationRecord
  belongs_to :animal
  belongs_to :nawoznaturalny
  has_many :systemyutrzymania, through: :animal

  def wykorzystany_azot
    self.ilosc * self.animal.zawartosc_wynikowa    
  end

  def wykorzystany_azot_dzialajacy
    self.ilosc * self.animal.zawartosc_wynikowa * self.animal.getrownowaznik(self.nawoznaturalny.sezon_id)
  end

  def wykorzystany_fosfor
    self.ilosc * self.animal.fosfor * self.animal.systemutrzymania.nazwautrzymania.wspwykorzystania.wsp_fosfor_i_rok
  end

  def wykorzystany_potas
    self.ilosc * self.animal.potas * self.animal.systemutrzymania.nazwautrzymania.wspwykorzystania.wsp_potas_i_rok
  end

end
