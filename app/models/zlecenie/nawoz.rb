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

  def pozostala_nawoz
    produkcja = 0
    @zlecenie.animals.each do |animal|
      produkcja += animal.pozostalynawoz
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

  def pozostaly_azot
    azot = 0
    @zlecenie.animals.each do |animal|
      azot += animal.pozostalyazot
    end
    azot
  end

  def fosfor
    fosfor = 0
    @zlecenie.animals.each do |animal|
      fosfor += animal.produkcja_fosfor
    end
    fosfor
  end

  def pozostaly_fosfor
    fosfor = 0
    @zlecenie.animals.each do |animal|
      fosfor += animal.pozostaly_fosfor
    end
    fosfor
  end

  def potas
    potas = 0
    @zlecenie.animals.each do |animal|
      potas += animal.produkcja_potas
    end
    potas
  end

  def pozostaly_potas
    potas = 0
    @zlecenie.animals.each do |animal|
      potas += animal.pozostaly_potas
    end
    potas
  end
  
end
