class CreateNawozynaturalne < ActiveRecord::Migration[5.0]
  def change
    create_table :nawozynaturalne do |t|
      t.references :uzytek, foreign_key: true
      t.references :animal, foreign_key: true
      t.references :sezon, foreign_key: true
      t.decimal :produkcja
      t.decimal :n

      t.timestamps
    end
  end
end
