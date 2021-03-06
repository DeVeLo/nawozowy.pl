# coding: utf-8
class Instytucja::Title


  def initialize(o)
    # object
    @o = o
    @instytucja = @o.zlecenie.instytucja
    
    @o.font_size 10.pt

  end  

  def bilans_firma_naglowek
    [
      [
        "ss"
      ]
    ]
  end
  
  # informacja o instytucji
  def firma (width = @o.bounds.width)
    { content: [
        # [miejscowosc_data],
        [
          nazwa(width),
        ],
        [adres],
        [kod_poczta],
        [tel],
        [mail]
      ],
      border_width: 0,
    }
  end

  # instytucja name
  def nazwa(width)
    { content: @instytucja.name,
      border_width: 0,
      width: width,
      align: :center,
      padding: [ 0.mm, 0, 0, 0 ],
      font_style: :bold,
    }
  end
  
  # adres instytucji
  def adres
    { content:
        @instytucja.miejscowosc +
      if @instytucja.ulica != '' && ! @instytucja.ulica.nil? then ", " + @instytucja.ulica + " " else " " end +
      @instytucja.nrp +
      if (@instytucja.nrm != '') && (!@instytucja.nrm.nil?) then ("/" + @instytucja.nrm) else "" end,
      border_width: 0,
      padding: [ 1.mm, 0, 0, 0 ],
      size: 10.pt,
      align: :center,
      font_style: :bold,
    }
  end

  # instytucja kod i poczta
  def kod_poczta
    { content: @instytucja.kod +
      " " +
      @instytucja.poczta,
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 10.pt,
      align: :center,
      font_style: :bold,
    }
  end  

  def tel
    { content: 'tel. ' + @instytucja.tel,
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 10.pt,
      align: :center,
      font_style: :bold,
    }
  end  
  
  def mail
    { content: @instytucja.www +
      ", " +
      @instytucja.mail,
      border_width: 0,
      padding: [ 3.pt, 0, 0, 0 ],
      size: 10.pt,
      align: :center,
      font_style: :bold,
    }
  end  
  
end
