# coding: utf-8
class Uzytek::Magnez

  def initialize(uzytek)

    @u = uzytek

  end

  # 1) ustalamy ocenę zawartości gleby
  def ocena
    Ocenamagnez.where(kategoria_id: @u.kategoria_id)
      .where(sad: @u.roslina.sad)
      .where('powyzej < ?', @u.magnez)
      .where('ponizej >= ?', @u.magnez).first
  end

  # 2) wyznaczamy współczynnik na podstawie oceny
  #     używamy dla tytoniu
  def korektatyton
    unless ocena.nil?
      # tylko rośliny oznaczone jako tytoń
      # mnożymy przez współczynnik - podobno tymczasowo (wg Moniki)
      if @u.roslina.tyton
        ocena.korektatyton
      else
        # reszt pozostaje neutralna
        1
      end
    else
      1
    end
  end
  
  # 2a) wyznaczamy równoważnik na podstawie oceny
  # jeśli tytoń to nie dodajemy równoważnika do magnezu
  def rownowaznik
    unless ocena.nil?
      if @u.roslina.tyton
        0
      else
        ocena.rownowaznik
      end
    else
      nil
    end
  end
  
  # 3) ustalamy pobranie
  def pobranie
    @u.roslina.magnez
  end

  # 4a) mnożymy przez 1.658 wszystko oprócz tytoniu
  def mnoznik1658
      if @u.roslina.tyton
        # tytoń pozostaje neutralny
        1
      else
        # resztę mnożymy
        1.658
      end
  end
  
  # 4) wyliczamy potrzeby rośliny
  def potrzeby
    unless pobranie.nil?
      mnoznik1658 * pobranie * @u.plon
    else
      nil
    end
  end

  # 5) wyznaczamy potrzeby nawozowe magnezu / ha
  #    faktyczny wynik (może być ujemny)
  def faktyczny_wynik 
    if @u.korekta_magnez.nil?
      unless rownowaznik.nil? or potrzeby.nil?
        potrzeby * korektatyton + rownowaznik
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
