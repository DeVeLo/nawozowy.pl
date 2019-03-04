# coding: utf-8
class Animal < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :zlecenie
  belongs_to :animalgroup
  belongs_to :zwierze
  belongs_to :nazwautrzymania
  belongs_to :systemutrzymania
  belongs_to :rownowaznik
  has_many :nawozynaturalne, dependent: :destroy
  has_many :nawozywykorzystane, dependent: :destroy

  before_save :koncentracja?

  def name
    self.zwierze.name
  end
  
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

  # pozostały nawóz po dodaniu do użytku
  def pozostalynawoz
    self.produkt - self.nawozywykorzystane.sum(:ilosc_na_pole)
  end

  # ilość wyprodukowanego nawozu w ciągu roku
  def azot
    self.produkt * self.zawartosc_wynikowa
  end
  
  # pozostały nawóz
  def pozostalyazot
    # ilość azotu w nawozie pozostałym po
    self.pozostalynawoz * self.zawartosc_wynikowa
  end

  # równoważnik
  def getrownowaznik(sezon)
    if sezon == 1
      self.rownowaznik.jesien
    elsif sezon == 2
      self.rownowaznik.wiosna
    else
      1
    end
  end
  
  
end
