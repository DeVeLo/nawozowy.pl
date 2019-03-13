# coding: utf-8
class Uzytek::Magnez

  def initialize(uzytek)

    @u = uzytek

  end

  # 1) ustalamy ocenę zawartości gleby
  def ocena
    Ocenamagnez.where(kategoria_id: @u.kategoria_id)
      .where('powyzej < ?', @u.magnez)
      .where('ponizej >= ?', @u.magnez).first
  end

  # 2) wyznaczamy równoważnik na podstawie oceny
  def rownowaznik
    unless ocena.nil?
      ocena.rownowaznik
    else
      nil
    end
  end
  
  # 3) ustalamy pobranie
  def pobranie
    @u.roslina.magnez
  end

  # 4) wyliczamy potrzeby rośliny
  def potrzeby
    unless pobranie.nil?
      1.658 * pobranie * @u.plon
    else
      nil
    end
  end

  # 5) wyznaczamy potrzeby nawozowe magnezu / ha
  #    faktyczny wynik (może być ujemny)
  def faktyczny_wynik 
    if @u.korekta_magnez.nil?
      unless rownowaznik.nil? or potrzeby.nil?
        potrzeby + rownowaznik
      else
        0
      end
    else
      @u.korekta_magnez
    end
  end
  
  # 5) jeśli faktyczny wynik jest ujemny podajemy 0
  #    w innym wypadku faktyczny wynik
  def wynik
    faktyczny_wynik < 0 ? 0 : faktyczny_wynik
  end

  # 6) ustalamy potrzeby nawozow
  def wynik_pole
    wynik * @u.powierzchnia
  end
  
  
  
end