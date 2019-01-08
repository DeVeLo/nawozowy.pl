class Systemutrzymania < ApplicationRecord
  belongs_to :jednostkautrzymania
  belongs_to :nazwautrzymania
  belongs_to :zwierze
end
