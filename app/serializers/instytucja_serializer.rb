class InstytucjaSerializer < ActiveModel::Serializer
  attributes :id, :name, :nip, :regon, :ulica, :nrp, :nrm
  has_one :wojewodztwo
  has_one :powiat
  has_one :gmina
end
