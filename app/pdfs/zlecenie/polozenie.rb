# coding: utf-8
class Zlecenie::Polozenie

  def initialize(o)
    # object
    @o = o
    
    @zlecenie = @o.zlecenie
    @rolnik = @o.zlecenie.rolnik
    @instytucja = @o.zlecenie.instytucja
    
    @o.font_size 9.pt

    # położenie gruntów
    polozenie_gruntow

    # adres
    adres

    # powierzchnia
    powierzchnia

    # Numer Identyfikacyjny Gospodarstwa
    nig
  end


  # położenie gruntów
  def polozenie_gruntow
    @o.move_down 10.pt
    @o.text "Położenie gruntów ujętych w planie, na których prowadzona jest produkcja roślin: ", align: :left, style: :normal, size: 9.pt, inline_format: true
  end

  # adres
  def adres
    @o.move_down 5.pt
    @o.text "· miejscowość: " + @zlecenie.miejscowosc + ", ", align: :left, style: :normal, size: 8.pt, inline_format: true
    @o.move_down 2.pt
    @o.text "· gmina: " + @zlecenie.gmina.name + ", ", align: :left, style: :normal, size: 8.pt, inline_format: true
    @o.move_down 2.pt
    @o.text "· powiat: " + @zlecenie.powiat.name + ", ", align: :left, style: :normal, size: 8.pt, inline_format: true
    @o.move_down 2.pt
    @o.text "· województwo: " + @zlecenie.wojewodztwo.name + ".", align: :left, style: :normal, size: 8.pt, inline_format: true
  end

  # powierzchnia
  def powierzchnia
    @o.move_down 5.pt
    @o.text "o powierzchni <b>" + @zlecenie.uzytki.sum(:powierzchnia).to_s + " ha</b> UR będących w posiadaniu", align: :left, style: :normal, size: 9.pt, inline_format: true
  end

  # NIG
  def nig
    @o.move_down 10.pt
    @o.text "Nr gospodarstwa rolnego nadany przez ARiMR <b>" + @rolnik.nig + "</b>.", align: :left, style: :normal, size: 9.pt, inline_format: true
  end
  
end
