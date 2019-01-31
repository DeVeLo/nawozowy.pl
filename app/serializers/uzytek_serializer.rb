class UzytekSerializer < ActiveModel::Serializer
  attributes :id, :name, :nmin, :prognoza, :instytucja_id, :rolnik_id,
             :zlecenie_id, :kategoria_id, :badania, :bobowata_id,
             :rodzajuprawy_id, :roslina_id, :plon, :powierzchnia, :zapotrzebowanie,
             :gleba, :nminsezon, :przelicznik, :jaraozima, :nazwarosliny, :wspolczynnikrosliny,
             :przedplon, :realnyprzedplon, :zprzedplonem, :roslinaprzedplon_id, :azot,
             :zroslinaprzedplon, :zbobowata, :nazwaroslinaprzedplon, :nazwabobowata
  
  belongs_to :kategoria
  belongs_to :rodzajuprawy
  belongs_to :roslina

  
end
