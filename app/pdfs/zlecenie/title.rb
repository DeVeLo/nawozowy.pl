# coding: utf-8
class Zlecenie::Title

  def initialize(o)
    # object
    @o = o
    
    @zlecenie = @o.zlecenie
    @rolnik = @o.zlecenie.rolnik
    @instytucja = @o.zlecenie.instytucja
    
    @o.font_size 9.pt

    # dane - tel., kom:, mail
    @rolnik_kontakt = []

    kolumny
  end

  # podział tytułu na kolumny
  def kolumny
    @o.table([[ klient, firma ]],
             { width: @o.bounds.width })
  end

  # LEWA STRONA - informacje o rolniku
  def klient
    { content: [
        [rolnik_fullname],
        [rolnik_gname],
        [rolnik_adres],
        [rolnik_poczta],
        [rolnik_powiat_gmina],
        [rolnik_wojewodztwo],
        [rolnik_tel_kom_mail],
      ],
      border_width: 0,
      width: 100.mm
      }
  end

  # imię i nazwisko rolnika
  def rolnik_fullname
    { content:
        @rolnik.name +
      " " +
      @rolnik.lname,
      border_width: 0,
      padding: 0 }
  end

  # nazwa przedsiębiorstwa rolnika
  def rolnik_gname
    { content: @rolnik.gname,
      border_width: 0,
      padding: [ 3.pt, 0, 3.pt, 0 ],
      size: 9.pt,
      font_style: :italic }
  end

  # adres rolnika
  def rolnik_adres
    { content:
        @rolnik.miejscowosc +
      if @rolnik.ulica != '' then ", " + @rolnik.ulica + " " else " " end +
      @rolnik.nrdom +
      if @rolnik.nrmieszkania != '' then ("/" + @rolnik.nrmieszkania) else "" end,
      border_width: 0,
      padding: [ 3.mm, 0, 0, 0 ],
      size: 9.pt }
  end

  # rolnik kod i poczta
  def rolnik_poczta
    { content: @rolnik.kod +
      " " +
      @rolnik.poczta,
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 9.pt }
  end

  # rolnik powiat i gmina
  def rolnik_powiat_gmina
    { content: "powiat " + @rolnik.powiat.name +
      ", " +
      @rolnik.gmina.name + " (" + @rolnik.gmina.name_dod + ")",
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 9.pt }
  end
  
  # wojewodztwo rolnika
  def rolnik_wojewodztwo
    { content: @rolnik.wojewodztwo.name,
      border_width: 0,
      padding: [ 3.pt, 0, 3.pt, 0 ],
      size: 9.pt }
  end

  # rolnik tel.
  def rolnik_tel_kom_mail
    rolnik_tel
    rolnik_kom
    rolnik_mail
    { content: @rolnik_kontakt.join(", "),
      border_width: 0,
      padding: [ 3.mm, 0, 3.pt, 0 ],
      size: 6.5.pt }
  end

  # rolnika tel.
  def rolnik_tel
    @rolnik_kontakt.push(
      if @rolnik.tel != ''
        "tel.: " + @rolnik.tel
      end
    )
  end

  # rolnika kom:
  def rolnik_kom
    @rolnik_kontakt.push(
      if @rolnik.kom != ''
        "kom: " + @rolnik.kom
      end
    )
  end

    # rolnika kom:
  def rolnik_mail
    @rolnik_kontakt.push(
      if @rolnik.mail != ''
        @rolnik.mail
      end
    )
  end

  # PRAWA STRONA - informacja o instytucji
  def firma
    { content: [
        [miejscowosc_data],
        [instytucja_name],
        [instytucja_adres],
        [instytucja_poczta],
      ],
      border_width: 0 }
  end

  # miejscowość i data
  def miejscowosc_data
    { content: "miejscowość, data: ...............................",
      border_width: 0,
      align: :right,
      width: 80.mm,
      size: 8.pt
    }
  end

  # instytucja name
  def instytucja_name
    { content: @instytucja.name,
      border_width: 0,
      align: :center,
      padding: [ 30.mm, 0, 0, 0 ] }
  end
  
  # adres instytucji
  def instytucja_adres
    { content:
        @instytucja.miejscowosc +
      if @instytucja.ulica != '' && !@instytucja.ulica.nil? then ", " + @instytucja.ulica + " " else " " end +
      @instytucja.nrp +
      if (@instytucja.nrm != '') && (!@instytucja.nrm.nil?) then ("/" + @instytucja.nrm) else "" end,
      border_width: 0,
      padding: [ 0.pt, 0, 0, 0 ],
      size: 7.pt,
      align: :center }
  end

  # instytucja kod i poczta
  def instytucja_poczta
    { content: @instytucja.kod +
      " " +
      @instytucja.poczta,
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 7.pt,
      align: :center }
  end
  
end
