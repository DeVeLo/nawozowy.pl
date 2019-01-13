class Systemutrzymania < ApplicationRecord
  belongs_to :jednostkautrzymania
  belongs_to :nazwautrzymania
  belongs_to :zwierze

  def self.wynik(zwierze_id, nazwautrzymania_id)
    Zwierze.find(zwierze_id).systemyutrzymania.joins(:nazwautrzymania).where(nazwyutrzymania: {id: nazwautrzymania_id }).first
  end
end
