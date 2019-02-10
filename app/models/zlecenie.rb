class Zlecenie < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :wariant
  belongs_to :podstawa
  belongs_to :gmina
  belongs_to :powiat
  belongs_to :wojewodztwo
  
  has_many :animalgroups, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :uzytki, dependent: :destroy
end
