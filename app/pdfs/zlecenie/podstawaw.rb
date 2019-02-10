# coding: utf-8
class Zlecenie::Podstawaw

  def initialize(o)
    # object
    @o = o
    
    @zlecenie = @o.zlecenie
    @rolnik = @o.zlecenie.rolnik
    @instytucja = @o.zlecenie.instytucja
    
    @o.font_size 9.pt

    if @zlecenie.wariant_id == 1
      wykonanie
    else
      zaopiniowanie
    end
    
  end
  
  # tekst wykonanie
  def wykonanie
    @o.move_down 10.pt
    @o.text wspolny + "planu nawożenia.", align: :left, style: :normal, size: 9.pt, inline_format: true
  end

  # tekst zaopiniowanie
  def zaopiniowanie
    @o.move_down 10.pt
    @o.text wspolny + "planu nawożenia opracowanego na podstawie " +
         podstawa + ".", align: :left, style: :normal, size: 9.pt, inline_format: true
  end

  # podstawa zaopiniowania
  def podstawa
    if @zlecenie.podstawa_id < 3
      @zlecenie.podstawa.name
    else
      @zlecenie.podstawainna
    end
  end
  
  # tekst wspólny
  def wspolny
    "Gospodarstwo Rolne zleca <b>" + @zlecenie.wariant.name + "</b> "
  end

end
