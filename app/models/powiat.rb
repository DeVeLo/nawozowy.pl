class Powiat < ApplicationRecord
  belongs_to :wojewodztwo
  has_many :gminy, dependent: :destroy

end
