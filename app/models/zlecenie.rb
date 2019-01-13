class Zlecenie < ApplicationRecord
  belongs_to :instytucja
  belongs_to :rolnik
  belongs_to :wariant
  belongs_to :podstawa
  has_many :animals, dependent: :destroy
end
