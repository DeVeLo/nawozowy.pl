class Gatunek < ApplicationRecord
  require('csv')
  has_many :zwierzeta, dependent: :destroy

  
  
  def self.import
    CSV.foreach('gatunki.csv', { col_sep: ';'}) do |r|
      if r[0].to_s.strip != ''
        puts r[0].to_s.strip
        Gatunek.create(name: r[0].to_s.strip)
      end
    end
  end
  
end
