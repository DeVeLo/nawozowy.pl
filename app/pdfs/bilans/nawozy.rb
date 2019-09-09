# coding: utf-8
class Bilans::Nawozy

  def initialize(parent)

    @parent = parent

  end

  def naglowek(title, title_nawoz, title_azot, title_dzialajacy = nil)
    
    naglowek = []
    
    naglowek.push({content:  title, size: 11.pt, font_style: :bold, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2})
    naglowek.push({content: title_nawoz, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
    naglowek.push({content: title_azot, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
    if title_dzialajacy != nil
      naglowek.push({content: title_dzialajacy, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
    end

    naglowek
  end

  def zagregowany(title, nawoz, azot, azot_dzialajacy = nil, allow_push = false)

    if nawoz.round > 0 || allow_push

      zagregowane = []

      zagregowane.push({content: title, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2})
      zagregowane.push({content: nawoz.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      zagregowane.push({content: azot.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      if azot_dzialajacy != nil
        zagregowane.push({content: azot_dzialajacy.round.to_s, size: 11.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      end

      zagregowane

    else
      
    end
    
  end

  def szczegolowy(title, nawoz, azot, azot_dzialajacy = nil, allow_push = false)

    if nawoz.round > 0 || allow_push

      zagregowane = []

      zagregowane.push({content: "└ " + title, size: 7.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 2.mm], width: @parent.bounds.width/2})
      zagregowane.push({content: "└ " + nawoz.round.to_s, size: 7.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      zagregowane.push({content: "└ " + azot.round.to_s, size: 7.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      if azot_dzialajacy != nil
        zagregowane.push({content: "└ " + azot_dzialajacy.round.to_s, size: 7.pt, font_style: :normal, border_width: 0, padding: [0.5.mm, 0, 0, 0], width: @parent.bounds.width/2/3})
      end

      zagregowane

    else
      
    end
    
  end
  
end
