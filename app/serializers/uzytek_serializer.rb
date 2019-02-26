class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza, :instytucja_id, :rolnik_id,
             :zlecenie_id, :kategoria_id, :badania, :bobowata_id,
             :rodzajuprawy_id, :roslina_id, :plon, :powierzchnia, :zapotrzebowanie,
             :gleba, :nminsezon, :przelicznik, :jaraozima, :nazwarosliny, :wspolczynnikrosliny,
             :przedplon, :realnyprzedplon, :zprzedplonem, :roslinaprzedplon_id, :azot,
             :zroslinaprzedplon, :zbobowata, :nazwaroslinaprzedplon, :nazwabobowata, :nawozynaturalne,
             :nawozynaturalne_attributes, :zanimalsami, :nawoznaturalny, :zapotrzebowanie_ha,
             :azot_mineralny_ha, :kategoria, :azot_naturalny_ha, :saldo_n, :azot_mineralny_ha_w_nawozie,
             :azot_mineralny_pole, :azot_naturalny_pole, :azot_pole, :nawoznaturalnyzastosowany,
             :azot_w_nawozie

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
  
  def kategoria
    object.kategoria.name
  end
  belongs_to :rodzajuprawy
  belongs_to :roslina

  
end
