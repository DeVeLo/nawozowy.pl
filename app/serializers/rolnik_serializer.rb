class RolnikSerializer < ActiveModel::Serializer
  belongs_to :gmina
  
  attributes :id, :name, :lname, :gname, :nig, :wojewodztwo_id, :powiat_id, :gmina_id, :miejscowosc, :nrdom, :nrmieszkania, :ulica, :instytucja_id, :kod, :poczta, :tel, :kom, :mail
end
