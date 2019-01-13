class Animal < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :zlecenie
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania

  def produkt
    self.sztuk * self.systemutrzymania.produkcja
  end

  def azot
    self.produkt * self.systemutrzymania.zawartosc
  end
  
end
