class Animal < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :zlecenie
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania

  before_save :koncentracja?
  
  def produkt
    self.sztuk * self.systemutrzymania.produkcja
  end

  def azot
    self.produkt * self.systemutrzymania.zawartosc * self.wspolczynnik_w
  end

  def wspolczynnik_w
    if self.specjalnezywienie
      self.zwierze.koncentracja
    else
      1
    end
  end
  
  def koncentracja?
    if self.zwierze.koncentracja == nil
      self.specjalnezywienie = false
    end
  end
  
end
