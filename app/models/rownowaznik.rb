class Rownowaznik < ApplicationRecord
  belongs_to :gatunek
  belongs_to :nazwautrzymania
  belongs_to :sezon
end
