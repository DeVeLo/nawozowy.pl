class Defaults::Fonts

  def initialize(o)
    o.font_families.update("Times New Roman" => {
                           :normal => "#{Rails.root}/app/assets/fonts/times.ttf",
                           :italic => "#{Rails.root}/app/assets/fonts/timesi.ttf",
                           :bold => "#{Rails.root}/app/assets/fonts/timesbd.ttf",
                           :bold_italic => "#{Rails.root}/app/assets/fonts/timesbi.ttf"
                         })
    o.font 'Times New Roman'
  end
  
end
