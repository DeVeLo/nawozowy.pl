class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza, :instytucja_id, :rolnik_id,
             :zlecenie_id, :kategoria_id, :badania, :bobowata_id,
             :rodzajuprawy_id, :roslina_id, :plon, :powierzchnia, :zapotrzebowanie,
             :gleba, :nminsezon, :przelicznik, :jaraozima, :nazwarosliny, :wspolczynnikrosliny,
             :przedplon, :realnyprzedplon, :zprzedplonem, :roslinaprzedplon_id, :azot,
             :zroslinaprzedplon, :zbobowata, :nazwaroslinaprzedplon, :nazwabobowata, :nawozynaturalne,
             :nawozynaturalne_attributes, :zanimalsami, :nawoznaturalny, :zapotrzebowanie_ha,
             :azot_mineralny_ha, :kategoria, :azot_naturalny_ha, :saldo_n, :azot_mineralny_ha_w_nawozie,
             :azot_mineralny_pole, :azot_naturalny_pole, :azot_pole, :nawoznaturalnyzastosowany, :grunt_id,
             :ph, :azot_w_nawozie, :cao, :cao_ha, :cao_pole, :weglanowa, :fosfor, :potas, :magnez,
             :przedplonfosfor, :przedplonpotas, :wspwykorzystania_id, :plonprzedplonowej, :wynik_fosfor, :wynik_potas,
             :lp, :stanprzedplonu, :zasob, :mg_wynik_ha, :korekta_azot, :korekta_fosfor, :korekta_potas, :korekta_magnez,
             :korekta_wapn

  def zasob
    object.kategoria.zasob
  end
  
  def nawozynaturalne_attributes
    nawozy = []
    
    object.nawozynaturalne.each do |nawoz|
      
      custom = nawoz.attributes
      
      custom[:sezon_name] = nawoz.sezon.name
      custom[:grupa] = nawoz.animalgroup.animalsname
      custom[:ilosc_na_pole] = nawoz.nawozywykorzystane.sum(:ilosc_na_pole)
      
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
