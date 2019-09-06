# coding: utf-8
class Zlecenie::Nawoz

  # klasa wylicza w odniesieniu do nawozu naturalnego:
  # 1) pełną produkcję roczną
  # 2) produkcję azotu
  # 3) ilość zakupionego nawozu naturalnego
  # 4) pozostałą ilość nawozu naturalnego
  # 5) pozostałą ilość azotu

  def initialize(zlecenie)
    @zlecenie = zlecenie
  end

  @metody = [
    {name: :produkcja_obornika, zrodlo: :produkt, nazwautrzymania_id: [1,2]},
    {name: :produkcja_gnojowki, zrodlo: :produkt, nazwautrzymania_id: 3},
    {name: :produkcja_gnojowicy, zrodlo: :produkt, nazwautrzymania_id: 4},
    {name: :produkcja_obornika_azot, zrodlo: :azot, nazwautrzymania_id: [1,2]},
    {name: :produkcja_gnojowki_azot, zrodlo: :azot, nazwautrzymania_id: 3},
    {name: :produkcja_gnojowicy_azot, zrodlo: :azot, nazwautrzymania_id: 4},
  ]

  # oblicz produkcję obornika, gnojówki i gnojowicy
  def oblicz(method, nazwautrzymania_id)
    suma = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: nazwautrzymania_id).each do |animal|
      unless animal.zrodlo
        suma += animal.send(method)
      end
    end
    suma
  end

  # ^^^ zdefiniuj dynamicznie metody ^^^
  @metody.each do |attr|
    define_method(attr[:name]) do
      oblicz(attr[:zrodlo], attr[:nazwautrzymania_id])
    end
  end

  @metody_zakup = [
    {name: :zakupiony_obornik, zrodlo: :produkt, nazwautrzymania_id: [1,2]},
    {name: :zakupiona_gnojowka, zrodlo: :produkt, nazwautrzymania_id: 3},
    {name: :zakupiona_gnojowica, zrodlo: :produkt, nazwautrzymania_id: 4},
    {name: :zakupiony_obornik_azot, zrodlo: :azot, nazwautrzymania_id: [1,2]},
    {name: :zakupiona_gnojowka_azot, zrodlo: :azot, nazwautrzymania_id: 3},
    {name: :zakupiona_gnojowica_azot, zrodlo: :azot, nazwautrzymania_id: 4},
  ]

  # oblicz zakup obornika, gnojówki i gnojowicy
  def oblicz_zakup(method, nazwautrzymania_id)
    suma = 0
    @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: nazwautrzymania_id).each do |animal|
      if animal.zrodlo
        suma += animal.send(method)
      end
    end
    suma
  end
  
  # ^^^ zdefiniuj dynamicznie metody ^^^
  @metody_zakup.each do |attr|
    define_method(attr[:name]) do
      oblicz_zakup(attr[:zrodlo], attr[:nazwautrzymania_id])
    end
  end

  @metody_pozostaly = [
    {name: :pozostaly_obornik, zrodlo: :pozostalynawoz, nazwautrzymania_id: [1,2]},
    {name: :pozostala_gnojowka, zrodlo: :pozostalynawoz, nazwautrzymania_id: 3},
    {name: :pozostala_gnojowica, zrodlo: :pozostalynawoz, nazwautrzymania_id: 4},
    {name: :pozostaly_obornik_azot, zrodlo: :pozostalyazot, nazwautrzymania_id: [1,2]},
    {name: :pozostala_gnojowka_azot, zrodlo: :pozostalyazot, nazwautrzymania_id: 3},
    {name: :pozostala_gnojowica_azot, zrodlo: :pozostalyazot, nazwautrzymania_id: 4},
  ]
    
  def oblicz_pozostaly(method, nazwautrzymania_id)
    suma = 0
     @zlecenie.animals.joins(:nazwautrzymania).where(nazwautrzymania_id: nazwautrzymania_id).each do |animal|
      suma += animal.send(method)
    end
    suma
  end

  # ^^^ zdefiniuj dynamicznie metody ^^^
  @metody_pozostaly.each do |attr|
    define_method(attr[:name]) do
      oblicz_pozostaly(attr[:zrodlo], attr[:nazwautrzymania_id])
    end
  end

  @metody_globalnie = [
    {name: :produkcja, zrodlo: :produkt},
    {name: :pozostala_nawoz, zrodlo: :pozostalynawoz},
    {name: :azot, zrodlo: :azot},
    {name: :pozostaly_azot, zrodlo: :pozostalyazot},
    {name: :fosfor, zrodlo: :produkcja_fosfor},
    {name: :pozostaly_fosfor, zrodlo: :pozostaly_fosfor},
    {name: :potas, zrodlo: :produkcja_potas},
    {name: :pozostaly_potas, zrodlo: :pozostaly_potas},
  ]

  def oblicz_globalnie(method)
    suma = 0
    @zlecenie.animals.each do |animal|
      suma += animal.send(method)
    end
    suma
  end

  # ^^^ zdefiniuj dynamicznie metody ^^^
  @metody_globalnie.each do |attr|
    define_method(attr[:name]) do
      oblicz_globalnie(attr[:zrodlo])
    end
  end

end
