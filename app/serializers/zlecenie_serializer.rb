class ZlecenieSerializer < ActiveModel::Serializer
  attributes :id, :name, :sprawa, :instytucja_id, :rolnik_id, :wariant_id, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc, :powierzchnia,
             :podstawa_id, :podstawainna, :datawplywu, :lp, :rejestr, :typ,
             :produkcja_nawozu, :produkcja_azotu, :pozostaly_nawoz, :pozostaly_azot,
             :produkcja_fosforu, :pozostaly_fosfor, :produkcja_potasu, :pozostaly_potas,
             :nawozynaturalne, :uzytki
  
  has_one :instytucja
  has_one :rolnik
  has_one :wariant
  has_one :podstawa
end
