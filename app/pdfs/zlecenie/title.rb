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
    @o.table([[ klient, Instytucja::Title.new(@o).firma ]],
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
      if @rolnik.ulica != '' && ! @rolnik.ulica.nil? then ", " + @rolnik.ulica + " " else " " end +
      @rolnik.nrdom +
      if @rolnik.nrmieszkania != '' && ! @rolnik.nrmieszkania.nil? then ("/" + @rolnik.nrmieszkania) else "" end,
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
    if @rolnik.tel != '' && ! @rolnik.tel.nil?
      @rolnik_kontakt.push(
        "tel.: " + @rolnik.tel
      )
    end
  end

  # rolnika kom:
  def rolnik_kom
    if @rolnik.kom != '' && ! @rolnik.kom.nil?
      @rolnik_kontakt.push(
        "kom: " + @rolnik.kom
      )
    end
  end

    # rolnika kom:
  def rolnik_mail
    if @rolnik.mail != '' && ! @rolnik.mail.nil?
      @rolnik_kontakt.push(
        @rolnik.mail
      )
    end
  end
  
end
