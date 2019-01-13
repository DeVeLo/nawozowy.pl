class Rolnik < ApplicationRecord
  belongs_to :wojewodztwo
  belongs_to :powiat
  belongs_to :gmina
  belongs_to :instytucja
  has_many :zlecenia, dependent: :destroy

  validates :wojewodztwo_id, :powiat_id, :gmina_id, presence: true
end
