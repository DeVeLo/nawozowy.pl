# coding: utf-8
class Wojewodztwo < ApplicationRecord
  require('csv')
  has_many :gminy
  has_many :powiaty, dependent: :destroy


  
  def self.import
    CSV.foreach('teryt.csv', col_sep: ';') do |r|
      # województwo
      if r[1].nil?
        puts r[4] + ' -> ' + r[0]
        Wojewodztwo.create(name: r[4], teryt: r[0], stanna: r[6])
      end

      # powiat
      if !r[1].nil? && r[2].nil? 
        puts r[4] + ' -> ' + r[0] + r[1]
        w = Wojewodztwo.find_by_teryt(r[0])
        Powiat.create(name: r[4], teryt: r[0]+r[1], wojewodztwo: w, stanna: r[6])
      end
      
      # gmina
      if !r[1].nil? && !r[2].nil?
        puts r[4] + ' -> ' + r[0] + r[1] + r[2]
        w = Wojewodztwo.find_by_teryt(r[0])
        p = Powiat.find_by_teryt(r[0]+r[1])
        Gmina.create(name: r[4], name_dod: r[5], teryt: r[0]+r[1]+r[2]+r[3], wojewodztwo: w, powiat: p, stanna: r[6])
      end

    end
  end
  
end
