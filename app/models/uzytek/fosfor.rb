# coding: utf-8
class Uzytek::Fosfor

  def initialize(uzytek)

    @u = uzytek

  end

  # 1) wyznaczamy współczynnik na podstawie
  #    wyników badań P2O5, kategorii agronomicznej
  #    oraz oznaczenia gleby - czy węglanowa czy nie
  def wspolczynnik
    r = Ocenafosfor.where(
      kategoria_id: @u.kategoria_id,
      weglanowa: @u.weglanowa)
      .where('powyzej < ?', @u.fosfor)
      .where('ponizej >= ?', @u.fosfor).first
    
    if r.nil?
      nil
    else
      r.ocena.wspolczynnik
    end
  end

  # 2) określamy pobranie rośliny
  def pobranie
    @u.roslina.fosfor
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

  # 5) ustalamy resztki pożniwne fosforu na podstawie
  #    plonu głównego rosliny przedplonowej, zawartości
  #    i mnożnika
  def resztki
    if @u.plonprzedplonowej.nil?
      0
    else
      @u.plonprzedplonowej * @u.roslinaprzedplon.fosfor * @u.roslinaprzedplon.mnoznik
    end
  end

  # 6) ustalamy zapas składnika z rośliny przedplonowej
  #    mnożymy resztki pożniwne fosforu
  #    przez współczynnik ilości składników pokarmowych dostępnych
  #    dla roślin następczych w kg z 1 tony przyoranego produktu ubocznego
  #    wg. T. Jadczyszyn
  def zapas
    if resztki.nil? or @u.roslinaprzedplon.wsp_fosfor_i_rok.nil?
      0
    else
      resztki * @u.roslinaprzedplon.wsp_fosfor_i_rok
    end
  end

  # 7) ustalamy zapasy składnika z nawozu naturalnego
  #    z II roku
  def zapasy_nawoz_ii
    if @u.przedplonfosfor.nil? or @u.wspwykorzystania_id.nil?
      nil
    else
      @u.przedplonfosfor * @u.wspwykorzystania.wsp_fosfor_ii_rok
    end
  end

  # 8) ustalamy zapas składnika z nawozu naturalnego
  #    z I roku
  def zapasy_nawoz_i
    # określam całkowitą ilość nawozu naturalnego
    suma = @u.nawozywykorzystane.sum(:ilosc)

    fosfor = 0
    @u.nawozywykorzystane.each do |nawoz|
      wsp = nawoz.ilosc / suma
      fosfor += nawoz.ilosc * nawoz.animal.fosfor * wsp * nawoz.animal.systemutrzymania.nazwautrzymania.wspwykorzystania.wsp_fosfor_i_rok
    end
    fosfor
  end

  # 9) dodajemy zapasy i odejmujemy zapotrzebowanie
  def wynik
    if zapasy_nawoz_ii.nil? or potrzeby_nawozowe.nil?
      nil
    else
      potrzeby_nawozowe - (zapas + zapasy_nawoz_i + zapasy_nawoz_ii)
    end
  end
  
end