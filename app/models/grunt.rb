class Grunt < ApplicationRecord
  has_and_belongs_to_many :stale
  has_and_belongs_to_many :plynne
end
