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
             :korekta_wapn, :pobranie_n, :pelne_pobranie_n, :fosfor_ocena_slowna, :potas_ocena_slowna, :magnez_ocena_slowna,
             :sloma_zebrana

  def pobranie_n
    object.roslina.pobranie
  end

  def pelne_pobranie_n
    object.roslina.pobranie * object.plon
  end
  
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
      custom[:wykorzystany_azot] = nawoz.wykorzystany_azot
      custom[:wykorzystany_azot_dzialajacy] = nawoz.wykorzystany_azot_dzialajacy
      custom[:wykorzystany_fosfor] = nawoz.wykorzystany_fosfor
      custom[:wykorzystany_potas] = nawoz.wykorzystany_potas

      custom[:wykorzystany_azot_pole] = nawoz.wykorzystany_azot * object.powierzchnia
      custom[:wykorzystany_azot_dzialajacy_pole] = nawoz.wykorzystany_azot_dzialajacy * object.powierzchnia
      custom[:wykorzystany_fosfor_pole] = nawoz.wykorzystany_fosfor * object.powierzchnia
      custom[:wykorzystany_potas_pole] = nawoz.wykorzystany_potas * object.powierzchnia
      
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
