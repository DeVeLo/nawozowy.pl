class Instytucja < ApplicationRecord
  belongs_to :wojewodztwo
  belongs_to :powiat
  belongs_to :gmina
  has_many :rolnicy
  
end
