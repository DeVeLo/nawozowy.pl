class Zlecenie::Preparation < ZleceniePdf

  def initialize(o)
    o.font_families.update("Arial" => {
                           :normal => "#{Rails.root}/app/assets/fonts/arial.ttf",
                           :italic => "#{Rails.root}/app/assets/fonts/ariali.ttf",
                           :bold => "#{Rails.root}/app/assets/fonts/arialbd.ttf",
                           :bold_italic => "#{Rails.root}/app/assets/fonts/arialbi.ttf"
                         })
    o.font 'Arial'
  end
  
end
