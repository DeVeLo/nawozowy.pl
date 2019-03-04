# coding: utf-8
class Zlecenie::Nawoz

  # klasa wylicza w odniesieniu do nawozu naturalnego:
  # 1) pełną produkcję roczną
  # 2) produkcję azotu
  # 3) pozostałą ilość nawozu naturalnego
  # 4) pozostałą ilość azotu

  def initialize(zlecenie)
    @zlecenie = zlecenie
  end
  
  def produkcja
    produkcja = 0
    @zlecenie.animals.each do |animal|
      produkcja += animal.produkt
    end
    produkcja
  end

  def azot
    azot = 0
    @zlecenie.animals.each do |animal|
      azot += animal.azot
    end
    azot
  end

  def pozostala_nawoz
    produkcja = 0
    @zlecenie.animals.each do |animal|
      produkcja += animal.pozostalynawoz
    end
    produkcja
  end

  def pozostaly_azot
    azot = 0
    @zlecenie.animals.each do |animal|
      azot += animal.pozostalyazot
    end
    azot
  end
  
end
