# coding: utf-8
class Animal < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :zlecenie
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania

  before_save :koncentracja?

  # jeśli nie ma współczynnika koncentracji
  # dla podanego zwierzęcia i systemu utrzymania
  # to wyłączamy w ogóle opcję specjalne żywienie
  def koncentracja?
    if self.zwierze.koncentracja == nil
      self.specjalnezywienie = false
    end
  end

  # jeśli specjalne żywienie jest włączone
  # zwracamy współczynnik w koncentracji
  # jeśli nie, zwracamy 1 (aby uniknąć błędów w obliczeniach mnożenia)
  def wspolczynnik_w
    if self.specjalnezywienie
      self.zwierze.koncentracja
    else
      1
    end
  end
  
  # zawartość pobrania z tabeli nr 9 lub z badań
  def zawartosc_wynikowa
    if self.badania
      self.zawartosc # badania
    else
      self.systemutrzymania.zawartosc * self.wspolczynnik_w # tabela nr 9 * współczynnik koncentracji "w"
    end
  end
  
  # ilość wyprodukowanego nawozu w ciągu roku
  def produkt
    self.sztuk * self.systemutrzymania.produkcja
  end

  # ilość wyprodukowanego nawozu w ciągu roku
  def azot
    self.produkt * self.zawartosc_wynikowa
  end
  
end
