# coding: utf-8
class Uzytek < ApplicationRecord
  belongs_to :kategoria
  belongs_to :rodzajuprawy
  belongs_to :roslina
  belongs_to :roslinaprzedplon
  belongs_to :bobowata

  # podsumowanie
  # prawa minus lewa
  def zestawienie
    zapotrzebowanie - azot
  end
  
  # LEWA STRONA
  # zapotrzebowanie na azot na danym polu
  def zapotrzebowanie
    plon * roslina.pobranie * powierzchnia
  end

  # PRAWA STRONA
  # ilość azotu działającego
  def azot
    zbobowata
  end

  # nazwa bobowatej
  def nazwabobowata
    bobowata.name
  end
  
  # z dodatkiem bobowatych
  def zbobowata
    if bobowata_id > 1
      zroslinaprzedplon + bobowata.n
    else
      zroslinaprzedplon
    end
  end
  
  # dodajemy azot z rośliny (przyorana słoma lub korzenie roślin korzeniowych)
  def zroslinaprzedplon
    if roslinaprzedplon_id > 1
      zprzedplonem + roslinaprzedplon.n
    else
      zprzedplonem
    end
  end

  # nazwa rośliny na przedplon
  def nazwaroslinaprzedplon
    roslinaprzedplon.name
  end
  
  # azot w glebie po zastosowaniu przedplonu
  def zprzedplonem
    jaraozima + realnyprzedplon
  end
  
  # realny azot z przedplonu jest wynikiem mnożenia przez 0.15
  def realnyprzedplon
    przedplon * 0.15
  end
  
  # zasobność mnożymy przez współczynnik
  # zależnie czy roślina jara czy ozima
  def jaraozima
    gleba * roslina.wspolczynnik
  end

  # współczynnik rośliny jara / ozima
  def wspolczynnikrosliny
    roslina.wspolczynnik
  end

  # nazwa roślinki
  def nazwarosliny
    roslina.rodzajuprawy.name + ': ' + roslina.name
  end
  
  # zasobność gleby w azot mineralny
  def gleba
    if badania
      nmin_sezon
    else
      kategoria.zasob
    end
  end

  # przelicznik jeżeli na podstawie badania
  # przeprowadzonego jesienią
  def przelicznik
    kategoria.przelicznik
  end

  # nmin z uwzględnieniem sezonu
  def nmin_sezon
    
    # jeśli true to jesień i trzeba przeliczyć na podstawie przelicznika
    # zależnego od kategorii gleby
    if nminsezon
      nmin * kategoria.przelicznik
      
    # jeśli false to wiosna
    else
      nmin
    end
      
  end
    
end
