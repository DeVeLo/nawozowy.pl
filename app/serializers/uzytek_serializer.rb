class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza, :instytucja_id, :rolnik_id,
             :zlecenie_id, :kategoria_id, :badania, :bobowata_id,
             :rodzajuprawy_id, :roslina_id, :plon, :powierzchnia, :zapotrzebowanie,
             :gleba, :nminsezon, :przelicznik, :jaraozima, :nazwarosliny, :wspolczynnikrosliny,
             :przedplon, :realnyprzedplon, :zprzedplonem, :roslinaprzedplon_id, :azot,
             :zroslinaprzedplon, :zbobowata, :nazwaroslinaprzedplon, :nazwabobowata, :nawozynaturalne,
             :nawozynaturalne_attributes, :zanimalsami, :nawoznaturalny, :zapotrzebowanie_ha, :podsumowanie_ha,
             :mineralny_ha

  def nawozynaturalne_attributes
    nawozy = []
    
    object.nawozynaturalne.each do |nawoz|
      
      custom = nawoz.attributes
      
      custom[:sezon_name] = nawoz.sezon.name
      custom[:grupa] = nawoz.animalgroup.animalsname

      nawozy.push(custom)
    end
    
    return nawozy
  end
  
  belongs_to :kategoria
  belongs_to :rodzajuprawy
  belongs_to :roslina

  
end
