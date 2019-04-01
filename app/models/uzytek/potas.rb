# coding: utf-8
class Uzytek::Potas

  def initialize(uzytek)

    @u = uzytek

  end

  # 1a)
  def wynik_oceny
    Ocenapotas.where(
      kategoria_id: @u.kategoria_id)
      .where(sad: @u.roslina.sad)
      .where('powyzej < ?', @u.potas)
      .where('ponizej >= ?', @u.potas).first
  end
    
  # 1) wyznaczamy współczynnik na podstawie
  #    wyników badań K2O, kategorii agronomicznej
  #    oraz oznaczenia gleby
  def wspolczynnik
    r = wynik_oceny
    
    if r.nil?
      nil
    else
      r.ocena.wspolczynnik
    end
  end

  # 1a) ocena słowna dla potasu
  def ocena_slowna
    unless wynik_oceny.nil?
      wynik_oceny.ocena.name
    else
      nil
    end
  end

  # 2) określamy pobranie rośliny
  def pobranie
    @u.roslina.potas
  end

  # 3) określamy potrzeby pokarmowe rośliny
  #    na podstawie pobrania i deklarowanego
  #    plonu
  def potrzeby_pokarmowe
    if pobranie.nil?
      nil
    else
      @u.plon * pobranie
    end
  end

  # 4) ustalamy potrzeby nawozowe uwzględniając zasobność
  #    gleby i potrzeby pokarmowe rośliny
  def potrzeby_nawozowe
    if potrzeby_pokarmowe.nil? or wspolczynnik.nil?
      nil
    else
      potrzeby_pokarmowe * wspolczynnik
    end
  end

  # 5) ustalamy resztki pożniwne potasu na podstawie
  #    plonu głównego rosliny przedplonowej, zawartości
  #    i mnożnika
  def resztki
    if @u.plonprzedplonowej.nil?
      0
    else
      
      @u.plonprzedplonowej * @u.roslinaprzedplon.potas * @u.roslinaprzedplon.mnoznik
    end
  end

  # 6) ustalamy zapas składnika z rośliny przedplonowej
  #    mnożymy resztki pożniwne potasu
  #    przez współczynnik ilości składników pokarmowych dostępnych
  #    dla roślin następczych w kg z 1 tony przyoranego produktu ubocznego
  #    wg. T. Jadczyszyn
  def zapas
    if resztki.nil? or @u.roslinaprzedplon.wsp_potas_i_rok.nil? or @u.stanprzedplonu
      0
    else
      resztki * @u.roslinaprzedplon.wsp_potas_i_rok
    end
  end

  # 7) ustalamy zapasy składnika z nawozu naturalnego
  #    z II roku
  def zapasy_nawoz_ii
    if @u.przedplonpotas.nil? or @u.wspwykorzystania_id.nil? or @u.wspwykorzystania_id == 4
      0
    else
      @u.przedplonpotas * @u.wspwykorzystania.wsp_potas_ii_rok
    end
  end

  # 8) ustalamy zapas składnika z nawozu naturalnego
  #    z I roku
  def zapasy_nawoz_i
    # określam całkowitą ilość nawozu naturalnego
    suma = @u.nawozywykorzystane.sum(:ilosc)

    potas = 0
    @u.nawozywykorzystane.each do |nawoz|
      wsp = nawoz.ilosc / suma
      potas += nawoz.ilosc * nawoz.animal.potas * wsp * nawoz.animal.systemutrzymania.nazwautrzymania.wspwykorzystania.wsp_potas_i_rok
    end
    potas
  end

  # 9) jeśli przedplon przyorany podajemy potrzeby nawozowe,
  #    jeśli natomiast zebrany to przemnażamy przez 1.2
  def potrzeby_nawozowe_przedplon
    if @u.roslinaprzedplon.id > 1 and @u.stanprzedplonu
      potrzeby_nawozowe * 1.7
    else
      potrzeby_nawozowe
    end
  end

  def wszystkie_zapasy
    (zapas + zapasy_nawoz_i + zapasy_nawoz_ii)
  end
  
  # 9) dodajemy zapasy i odejmujemy zapotrzebowanie
  def wynik_przed
    if zapasy_nawoz_ii.nil? or potrzeby_nawozowe.nil?
      nil
    else
      potrzeby_nawozowe_przedplon - wszystkie_zapasy
    end
  end

  def wynik
    unless wynik_przed.nil?
      if wynik_przed < 0
        0
      else
        wynik_przed
      end
    else
      nil
    end
  end
    
end
