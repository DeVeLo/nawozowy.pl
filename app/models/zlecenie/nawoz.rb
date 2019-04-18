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

  def produkcja_obornika
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      unless animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end

  def produkcja_gnojowki
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      unless animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end

  def produkcja_gnojowicy
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      unless animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end  
  
  def produkcja_obornika_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      unless animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end

  def produkcja_gnojowki_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      unless animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end

  
  def produkcja_gnojowicy_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      unless animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end

  def zakupiony_obornik
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      if animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end

  def zakupiona_gnojowka
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      if animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end

  def zakupiona_gnojowica
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      if animal.zrodlo
        produkcja += animal.produkt
      end
    end
    produkcja
  end  

  def zakupiony_obornik_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      if animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end

  def zakupiona_gnojowka_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      if animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end

  
  def zakupiona_gnojowica_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      if animal.zrodlo
        azot += animal.azot
      end
    end
    azot
  end
  
  def pozostaly_obornik
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      produkcja += animal.pozostalynawoz
    end
    produkcja
  end

  def pozostala_gnojowka
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      produkcja += animal.pozostalynawoz
    end
    produkcja
  end

  def pozostala_gnojowica
    produkcja = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      produkcja += animal.pozostalynawoz
    end
    produkcja
  end  

  def pozostaly_obornik_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: [1,2]).each do |animal|
      azot += animal.pozostalyazot
    end
    azot
  end

  def pozostala_gnojowka_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 3).each do |animal|
      azot += animal.pozostalyazot
    end
    azot
  end

  
  def pozostala_gnojowica_azot
    azot = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: 4).each do |animal|
      azot += animal.pozostalyazot
    end
    azot
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
