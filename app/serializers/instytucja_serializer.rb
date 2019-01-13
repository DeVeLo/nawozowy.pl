class InstytucjaSerializer < ActiveModel::Serializer
  attributes :id, :name, :nip, :regon, :ulica, :nrp, :nrm, :tel, :fax, :miejscowosc, :mail, :kod, :poczta
  has_one :wojewodztwo
  has_one :powiat
  has_one :gmina
end
