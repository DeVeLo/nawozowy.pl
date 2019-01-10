class Gmina < ApplicationRecord
  belongs_to :wojewodztwo
  belongs_to :powiat
  has_and_belongs_to_many :stale
  has_and_belongs_to_many :plynne
  
  validates :wojewodztwo, :powiat, presence: true

  def plynny(grunt)
    self.plynne.joins(:grunty).where(grunty: { id: grunt.id } ).first
  end

  def staly(grunt)
    self.stale.joins(:grunty).where(grunty: { id: grunt.id } ).first
  end
  
end
