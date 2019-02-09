class Rownowaznik < ApplicationRecord
  belongs_to :gatunek
  belongs_to :nazwautrzymania
  belongs_to :sezon
  belongs_to :zwierze
  has_many :animals

  def self.wynik(zwierze_id, nazwautrzymania_id)
    Zwierze.find(zwierze_id).rownowazniki.joins(:nazwautrzymania).where(nazwyutrzymania: {id: nazwautrzymania_id })
  end

end
